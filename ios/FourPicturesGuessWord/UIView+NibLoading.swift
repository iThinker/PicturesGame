//
//  UIView+NibLoading.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-20.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadDefaultNib() -> Self? {
        return self.instantiateNib()
    }
    
    class func defaultNibName() -> String {
        return String(describing: self)
    }
    
    fileprivate class func instantiateNib<T>() -> T? {
        let view = Bundle(for: self).loadNibNamed(self.defaultNibName(), owner: nil, options: nil)?.first as? T
        return view
    }
    
}
