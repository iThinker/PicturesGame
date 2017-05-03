//
//  ReuseIdentifier.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-25.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    class func defaultReuseIdentifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    class func defaultReuseIdentifier() -> String {
        return String(describing: self)
    }
}
