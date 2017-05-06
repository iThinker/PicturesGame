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
        self.tableViewController.onSelectProduct = {
            [unowned self]
            product in
            self.presenter.purchase(product)
        }
        self.embed(self.tableViewController, in: self.tableViewContainer)
    }

}

extension ProductListViewController: ProductListPresentable {
    
    func showLoading(_ visible: Bool) {
        visible ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }

    func showPurchaseSuccess() {
        SVProgressHUD.showSuccess(withStatus: NSLocalizedString("Success!", comment: ""))
    }
    
    func showProducts(_ products: [ProductListPresenter.PresentableModel]) {
        self.tableViewController.showProducts(products)
    }
    
    func showError(_ error: Error) {
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
    
}
