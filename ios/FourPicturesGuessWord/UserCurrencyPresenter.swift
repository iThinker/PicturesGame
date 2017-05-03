//
//  UserCurrencyPresenter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-22.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

protocol UserCurrencyPresentable: class {
    func showAmount(_ amount: Int)
}

class UserCurrencyPresenter {
    
    weak var presentable: UserCurrencyPresentable!
    var userCurrency: UserCurrency!
    var onSelect: (() -> Void)!
    
    func startPresentation() {
        self.presentable.showAmount(self.userCurrency.getAmount())
        UserCurrency.AmountChangedDomainEvent.subscribe(observer: self) {
            [weak self]
            (event) in
            self?.presentable.showAmount(event.newAmount)
        }
    }
    
    func select() {
        self.onSelect()
    }
    
}
