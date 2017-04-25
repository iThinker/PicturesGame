//
//  RewardPlayerForCompletingLevel.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-24.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class RewardPlayerForCompletingLevel {
    
    let rewardAwmount = 10
    
    var userCurrency: UserCurrency!
    
    func reward() {
        self.userCurrency.appendAmount(self.rewardAwmount)
    }
    
}
