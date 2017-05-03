//
//  ProductView.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-30.
//  Copyright © 2017 Temkos. All rights reserved.
//

import UIKit

class ProductView: UIView {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var product: ProductListPresenter.PresentableModel!
    
    func showProduct(_ product: ProductListPresenter.PresentableModel) {
        self.imageView.image = product.image
        self.priceLabel.text = self.formatPrice(product.price, locale: product.priceLocale)
        self.descriptionLabel.text = product.description
        self.titleLabel.text = product.title
    }
    
    fileprivate static var sharedNumberFomatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    fileprivate func formatPrice(_ price: NSDecimalNumber, locale: Locale) -> String {
        let formatter = ProductView.sharedNumberFomatter
        formatter.locale = locale
        return formatter.string(from: price)!
    }
    
}
