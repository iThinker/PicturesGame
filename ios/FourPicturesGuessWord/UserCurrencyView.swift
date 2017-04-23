//
//  UserCurrencyView.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-23.
//  Copyright © 2017 Temkos. All rights reserved.
//

import UIKit

class UserCurrencyView: UIView {
    
    @IBOutlet var userCurrencyLabel: UILabel!
    private(set) var presenter: UserCurrencyPresenter?
    
    func show(_ presenter: UserCurrencyPresenter) {
        self.presenter = presenter
        presenter.presentable = self
        presenter.startPresentation()
    }
    
}

extension UserCurrencyView: UserCurrencyPresentable {
    
    func showAmount(_ amount: Int) {
        self.userCurrencyLabel.text = "\(amount)"
    }
    
}
