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


private class DomainEventObservationInfoContainer {
    
    var observationInfo: NSObjectProtocol
    
    init(observationInfo: NSObjectProtocol) {
        self.observationInfo = observationInfo
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self.observationInfo)
    }
    
}

extension DomainEvent {
    
    static var notificationName: Notification.Name {
        return Notification.Name(String(describing: self))
    }
    
    static func subscribe(observer: AnyObject, queue: OperationQueue = OperationQueue.main, emitter: AnyObject? = nil, subscription: @escaping Subscription) {
        let observationInfo = NotificationCenter.default.addObserver(forName: Self.notificationName, object: emitter, queue: queue) { (notification) in
            let domainEvent = notification.userInfo?[DomainEventKey] as! Self
            subscription(domainEvent)
        }
        let observationInfoContainer = DomainEventObservationInfoContainer(observationInfo: observationInfo)
        setAssociation(observationInfoContainer, forKey: self.notificationName.rawValue, object: observer)
    }
    
    static func unsubscribe(observer: AnyObject) {
        let observationInfoContainer: DomainEventObservationInfoContainer? = getAssociation(forKey: self.notificationName.rawValue, object: observer)
        if let observationInfo = observationInfoContainer?.observationInfo {
            NotificationCenter.default.removeObserver(observationInfo)
        }
    }
    
    func post(_ emitter: AnyObject? = nil) {
        NotificationCenter.default.post(name: Self.notificationName, object: emitter, userInfo: [DomainEventKey: self])
    }
    
}
