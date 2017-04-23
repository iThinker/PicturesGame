//
//  DomainEvent.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-20.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

protocol DomainEvent {
    
    typealias Subscription = (Self) -> Void
    
    static var notificationName: Notification.Name { get }
    
}

let DomainEventKey = "DomainEventKey"

extension DomainEvent {
    
    static var notificationName: Notification.Name {
        return Notification.Name(String(describing: self))
    }
    
    static func subscribe(observer: AnyObject, queue: OperationQueue = OperationQueue.main, subscription: @escaping Subscription) {
        let observationInfo = NotificationCenter.default.addObserver(forName: Self.notificationName, object: nil, queue: queue) { (notification) in
            let domainEvent = notification.userInfo?[DomainEventKey] as! Self
            subscription(domainEvent)
        }
        setAssociation(observationInfo, forKey: self.notificationName.rawValue, object: observer)
    }
    
    static func unsubscribe(observer: AnyObject) {
        let observationInfo: NSObjectProtocol = getAssociation(forKey: self.notificationName.rawValue, object: observer)!
        NotificationCenter.default.removeObserver(observationInfo)
    }
    
    func post() {
        NotificationCenter.default.post(name: Self.notificationName, object: nil, userInfo: [DomainEventKey: self])
    }
    
}
