//
//  ProductListPresenter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-29.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation
import UIKit

protocol ProductListPresentable: class {
    
    func showProducts(_ products: [ProductListPresenter.PresentableModel])
    func showError(_ error: Error)
    
}

class ProductListPresenter {
    
    struct PresentableModel {
        let id: String
        let title: String
        let description: String
        let price: NSDecimalNumber
        let priceLocale: Locale
        let image: UIImage
    }
    
    weak var presentable: ProductListPresentable!
    var getProductList: GetProductList!
    
    fileprivate var products: [Product] = []
    
    func startPresentation() {
        self.getProductList.get().then { (products) -> Void in
            self.didGetProducts(products)
            }.catch { (error) in
                self.presentable.showError(error)
        }
    }
    
    //MARK: Private
    
    fileprivate func didGetProducts(_ products: [Product]) {
        self.products = products
        let presentableModels = products.map({ (product) -> PresentableModel in
            return PresentableModel(id: product.id, title: product.title, description: product.description, price: product.price, priceLocale: product.priceLocale, image: product.image)
        })
        self.presentable.showProducts(presentableModels)
    }
    
}
