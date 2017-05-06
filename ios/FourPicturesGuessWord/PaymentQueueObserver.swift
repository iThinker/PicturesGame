//
//  PaymentQueueObserver.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-05-03.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation
import StoreKit

class PaymentQueueObserver: NSObject, SKPaymentTransactionObserver {
    
    struct TransactionResult {
        var productIdentifier: String
        var error: Error?
        var success = false
    }
    
    struct TransactionCompleteDomainEvent: DomainEvent {
        var result: TransactionResult
    }
    
    static let shared = PaymentQueueObserver()
    
    func startObserving() {
        SKPaymentQueue.default().add(self)
    }
    
    func submit(payment: SKPayment) {
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                self.completeTransaction(transaction, success: true, error: nil)
                break
            case .deferred:
                break
            case .purchasing:
                break
            case .failed:
                var resolvedError: Error? = nil
                if let error = transaction.error as NSError? {
                    if error.code != SKError.paymentCancelled.rawValue {
                        resolvedError = error
                    }
                }
                else {
                    resolvedError = NSError(domain: "App", code: 0, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Unknown error when purchasing product", comment: "")])
                }
                self.completeTransaction(transaction, success: false, error: resolvedError)
                break
            case .restored:
                let error = NSError(domain: "App", code: 0, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Purchase is not restorable", comment: "")])
                self.completeTransaction(transaction, success: false, error: error)
                break
            }
        }
    }
    
    private func completeTransaction(_ transaction: SKPaymentTransaction, success: Bool, error: Error?) {
        SKPaymentQueue.default().finishTransaction(transaction)
        let result = TransactionResult(productIdentifier: transaction.payment.productIdentifier, error: error, success: success)
        TransactionCompleteDomainEvent(result: result).post()
    }
    
}
