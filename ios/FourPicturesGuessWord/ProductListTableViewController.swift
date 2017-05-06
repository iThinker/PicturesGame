//
//  ProductListTableViewController.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-30.
//  Copyright © 2017 Temkos. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {
    
    typealias Cell = TableViewContainerCell<ProductView>
    
    var products: [ProductListPresenter.PresentableModel] = []
    var onSelectProduct: ((ProductListPresenter.PresentableModel) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(Cell.self, forCellReuseIdentifier: Cell.defaultReuseIdentifier())
    }
    
    func showProducts(_ products: [ProductListPresenter.PresentableModel]) {
        self.products = products
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.defaultReuseIdentifier(), for: indexPath) as! Cell
        
        let product = self.products[indexPath.row]
        cell.content.showProduct(product)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        self.onSelectProduct(product)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
