//
//  ViewEmbedder.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-20.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class ViewEmbedder {
    
    class func embed(_ view: UIView, in containerView: UIView) {
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: [], metrics: nil, views: ["view": view]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: [], metrics: nil, views: ["view": view]))
    }
    
}

extension UIView {
    
    func embed(_ view: UIView) {
        ViewEmbedder.embed(view, in: self)
    }
    
}
