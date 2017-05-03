//
//  ProductListViewController.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-30.
//  Copyright © 2017 Temkos. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProductListViewController: UIViewController {

    var presenter: ProductListPresenter!
    
    @IBOutlet var tableViewContainer: UIView!
    
    fileprivate let tableViewController = ProductListTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        
        self.presenter.presentable = self
        self.presenter.startPresentation()
    }
    
    fileprivate func configure() {
        self.embed(self.tableViewController, in: self.tableViewContainer)
    }

}

extension ProductListViewController: ProductListPresentable {
    
    func showProducts(_ products: [ProductListPresenter.PresentableModel]) {
        self.tableViewController.showProducts(products)
    }
    
    func showError(_ error: Error) {
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
    
}
