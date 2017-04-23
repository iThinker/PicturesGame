//
//  UsserCurrency.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-22.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class UserCurrency {
    
    enum Error: LocalizedError {
        case notEnoughCurrency
        
        var errorDescription: String? {
            switch self {
            case .notEnoughCurrency:
                return NSLocalizedString("Not Enough Currency", comment: "")
            }
        }
    }
    
    var repository: CurrencyRepository!
    
    func getAmount() -> Int {
        return tryAndLog(try self.repository.getAmount(), withDefault: 0)
    }
    
    func appendAmount(_ amount: Int) throws {
        let oldAmount = try self.repository.getAmount()
        let newAmount = oldAmount + amount
        try self.repository.setAmount(newAmount)
    }
    
    func substractAmount(_ amount: Int) throws {
        try self.checkIfEnoughCurrencyToSubstract(amount: amount)
        let oldAmount = try self.repository.getAmount()
        let newAmount = oldAmount - amount
        try self.repository.setAmount(newAmount)
    }
    
    fileprivate func checkIfEnoughCurrencyToSubstract(amount: Int) throws {
        if amount > self.getAmount() {
            throw Error.notEnoughCurrency
        }
    }
    
}
