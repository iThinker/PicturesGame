//
//  ProductsFactory.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-05-02.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class ProductsFactory {
    
    static let shared = ProductsFactory()
    
    func listViewController() -> ProductListViewController {
        let viewController = ProductListViewController()
        viewController.presenter = self.listPresenter()
        return viewController
    }
    
    func listPresenter() -> ProductListPresenter {
        let presenter = ProductListPresenter()
        presenter.getProductList = self.getProductList()
        return presenter
    }
    
    func repository() -> ProductRepository {
        return ProductRepository()
    }
    
    func getProductList() -> GetProductList {
        let interactor = GetProductList()
        interactor.repository = self.repository()
        return interactor
    }
    
}
