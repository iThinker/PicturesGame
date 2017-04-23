//
//  ObjectAssociation.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-20.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

func setAssociation<T>(_ association: T?, forKey key: UnsafeRawPointer, object: AnyObject) {
    switch association {
    case .some(let value):
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN)
        break
    case .none:
        objc_setAssociatedObject(object, key, nil, .OBJC_ASSOCIATION_RETAIN)
        break
    }
}

func getAssociation<T>(forKey key: UnsafeRawPointer, object: AnyObject) -> T? {
    let association = objc_getAssociatedObject(object, key)
    return association as? T
}
