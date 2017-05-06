//
//  PaymentTransactionResultObserver.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-05-04.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class PaymentTransactionResultObserver {
    
    static let shared = PaymentTransactionResultObserver()
    
    var productRepository: ProductRepository!
    var userCurrency: UserCurrency!
    
    init() {
        PaymentQueueObserver.TransactionCompleteDomainEvent.subscribe(observer: self) {
            [unowned self]
            (event) in
            self.eventReceived(event)
        }
    }
    
    fileprivate func eventReceived(_ event: PaymentQueueObserver.TransactionCompleteDomainEvent) {
        let result = event.result
        if result.success {
            _ = self.productRepository.getLocalProductInfo(forProductIdentifier: result.productIdentifier).then { product -> Void in
                self.userCurrency.appendAmount(product.currencyAmount)
            }
        }
    }
    
}
