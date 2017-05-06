//
//  ProductRepository.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-25.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation
import UIKit
import StoreKit
import PromiseKit

class ProductRepository {
    
    enum Error: Swift.Error {
        case notFound
    }
    
    private var runningTransactions: [ProductRequestTransactionRunner] = []
    
    func getProductList() -> Promise<[Product]> {
        var products: [Product] = []
        return firstly { _ in
            self.getProductsFromCache()
            }.then { (resultProducts) -> Promise<SKProductsResponse> in
                products = resultProducts
                return self.getPrinceInfo(for: products)
            } .then { (response) -> [Product] in
                let updatedProducts = self.mergeProductsWithPriceInfo(products, response)
                return updatedProducts
        }
    }
    
    func getLocalProductInfo(forProductIdentifier productIdentifier: String) -> Promise<Product> {
        return firstly { _ in
            self.getProductsFromCache()
            }.then { products -> Product in
                if let product = products.first(where: { $0.id == productIdentifier }) {
                    return product
                }
                else {
                    throw Error.notFound
                }
        }
    }
    
    //MARK: Private
    
    private func getProductsFromCache() -> Promise<[Product]> {
        func getProductInfoFromLocalStorage() throws -> [[String: Any]] {
            let path = Bundle.main.url(forResource: "Products", withExtension: "json")!
            let productsData = try Data(contentsOf: path)
            let productDictionaries = try JSONSerialization.jsonObject(with: productsData, options: []) as! [[String: Any]]
            return productDictionaries
        }
        
        func productFromLocalProductInfo(_ productInfo: [String: Any]) -> Product {
            let product = Product()
            product.id = productInfo["id"] as! String
            product.image = UIImage(named: productInfo["imageName"] as! String)
            product.currencyAmount = productInfo["currencyAmount"] as! Int
            return product
        }
        
        return firstly { () -> Promise<[Product]> in
            let productDictionaries = try getProductInfoFromLocalStorage()
            let products = productDictionaries.map { (productDict) -> Product in
                return productFromLocalProductInfo(productDict)
            }
            return Promise(value: products)
        }
    }
    
    private func getPrinceInfo(for products: [Product]) -> Promise<SKProductsResponse> {
        let request = SKProductsRequest(productIdentifiers: Set(products.map({ $0.id })))
        let runner = ProductRequestTransactionRunner(request: request)
        
        self.runningTransactions.append(runner)
        return runner.run().always {
            self.runningTransactions.removeAll(where: { $0 === runner })
        }
    }
    
    private func mergeProductsWithPriceInfo(_ products: [Product], _ priceInfo: SKProductsResponse) -> [Product] {
        var localProducts = products
        if priceInfo.invalidProductIdentifiers.isEmpty == false {
            print("Found invalid products")
            localProducts.removeAll(where: { priceInfo.invalidProductIdentifiers.contains($0.id) })
        }
        priceInfo.products.forEach { (skProduct) in
            let product = localProducts.first(where: { $0.id == skProduct.productIdentifier })!
            product.price = skProduct.price
            product.priceLocale = skProduct.priceLocale
            product.description = skProduct.localizedDescription
            product.title = skProduct.localizedTitle
            product.skProduct = skProduct
        }
        
        return products
    }
    
    private class ProductRequestTransactionRunner: NSObject, SKProductsRequestDelegate {
        
        var request: SKProductsRequest
        var fulfill: ((SKProductsResponse) -> Void)!
        var reject: ((Swift.Error) -> Void)!
        
        init(request: SKProductsRequest) {
            self.request = request
            super.init()
            request.delegate = self
        }
        
        func run() -> Promise<SKProductsResponse> {
            let promise = Promise<SKProductsResponse> { (fulfill, reject) in
                self.fulfill = fulfill
                self.reject = reject
            }
            self.request.start()
            return promise
        }
        
        func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
            fulfill(response)
        }
        
        func request(_ request: SKRequest, didFailWithError error: Swift.Error) {
            reject(error)
        }
        
    }
    
}
