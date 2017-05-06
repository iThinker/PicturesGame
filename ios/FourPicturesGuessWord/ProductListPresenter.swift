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
    func showLoading(_ visible: Bool)
    func showPurchaseSuccess()
    
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
    var paymentService: PaymentService!
    var onPurchaseComplete: (() -> Void)!
    
    fileprivate var products: [Product] = []
    
    func startPresentation() {
        self.presentable.showLoading(true)
        self.getProductList.get().then { (products) -> Void in
            self.didGetProducts(products)
            }.always {
                self.presentable.showLoading(false)
            }.catch { (error) in
                self.presentable.showError(error)
        }
    }
    
    func purchase(_ presentableModel: PresentableModel) {
        self.presentable.showLoading(true)
        PaymentService.PurchaseCompleteDomainEvent.subscribe(observer: self) {
            [unowned self]
            (event) in
            self.presentable.showLoading(false)
            type(of: event).unsubscribe(observer: self)
            if event.result.success {
                self.presentable.showPurchaseSuccess()
                self.onPurchaseComplete()
            }
            else if let error = event.result.error {
                self.presentable.showError(error)
            }
        }
        let product = self.products.first(where: { $0.id == presentableModel.id })!
        self.paymentService.purchase(product)
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
