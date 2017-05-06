//
//  CurrencyRepository.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-20.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation
import SAMKeychain

class CurrencyRepository {
    
    private let CurrencyService = "com.fourpicturesguessword.currency"
    private let CurrencyAccount = "currency"
    
    func getAmount() throws -> Int {
        var error: NSError?
        let amountString = SAMKeychain.password(forService: CurrencyService, account: CurrencyAccount, error: &error)
        let amount = Int(amountString ?? "") ?? 0
        if let error = error {
            if error.code != Int(errSecItemNotFound) {
                throw error
            }
        }
        
        return amount
    }
    
    func setAmount(_ amount: Int) throws {
        var error: NSError?
        SAMKeychain.setPassword("\(amount)", forService: CurrencyService, account: CurrencyAccount, error: &error)
        if let error = error {
            throw error
        }
    }
    
}
