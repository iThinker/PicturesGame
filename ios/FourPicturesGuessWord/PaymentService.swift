//
//  PaymentService.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-05-04.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation
import StoreKit

class PaymentService {
    
    typealias PurchaseCompleteDomainEvent = PaymentQueueObserver.TransactionCompleteDomainEvent
    typealias PurchaseResult = PaymentQueueObserver.TransactionResult
    
    var paymentQueueObserver: PaymentQueueObserver!
    
    func purchase(_ product: Product) {
        let payment = SKPayment(product: product.skProduct)
        self.paymentQueueObserver.submit(payment: payment)
    }
    
}
