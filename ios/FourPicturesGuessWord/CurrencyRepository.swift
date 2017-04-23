//
//  CurrencyRepository.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-20.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class CurrencyRepository {
    
    static var amount = 0
    
    func getAmount() throws -> Int {
        return CurrencyRepository.amount
    }
    
    func setAmount(_ amount: Int) throws {
        CurrencyRepository.amount = amount
    }
    
}
