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
    
    struct AmountChangedDomainEvent: DomainEvent {
        var newAmount: Int = 0
    }
    
    var repository: CurrencyRepository!
    
    func getAmount() -> Int {
        return tryAndLog(try self.repository.getAmount(), withDefault: 0)
    }
    
    func appendAmount(_ amount: Int) throws {
        try self.updateAmount { (oldAmount) -> Int in
            return oldAmount + amount
        }
    }
    
    func substractAmount(_ amount: Int) throws {
        try self.checkIfEnoughCurrencyToSubstract(amount: amount)
        try self.updateAmount { (oldAmount) -> Int in
            return oldAmount - amount
        }
    }
    
    fileprivate func checkIfEnoughCurrencyToSubstract(amount: Int) throws {
        if amount > self.getAmount() {
            throw Error.notEnoughCurrency
        }
    }
    
    fileprivate func updateAmount(with updater: (Int) -> Int) throws {
        let oldAmount = try self.repository.getAmount()
        let newAmount = updater(oldAmount)
        try self.repository.setAmount(newAmount)
        AmountChangedDomainEvent(newAmount: newAmount).post()
    }
    
}
