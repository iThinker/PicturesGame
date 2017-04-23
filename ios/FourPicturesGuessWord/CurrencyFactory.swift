//
//  UserCurrencyFactory.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-22.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class CurrencyFactory {
    
    static let shared = CurrencyFactory()
    static let sharedUserCurrency = shared.userCurrency()
    
    func userCurrency() -> UserCurrency {
        let entity = UserCurrency()
        entity.repository = self.currencyRepository()
        return entity
    }
    
    func currencyRepository() -> CurrencyRepository {
        return CurrencyRepository()
    }
    
}
