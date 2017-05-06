//
//  PaymentFactory.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-05-04.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class PaymentFactory {
    
    static let shared = PaymentFactory()
    
    func service() -> PaymentService {
        let service = PaymentService()
        service.paymentQueueObserver = PaymentQueueObserver.shared
        return service
    }
    
}
