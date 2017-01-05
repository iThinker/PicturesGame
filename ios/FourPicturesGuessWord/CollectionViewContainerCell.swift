//
//  CollectionViewContainerCell.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-25.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class CollectionViewContainerCell<Content: UIView>: UICollectionViewCell {
    
    var content: Content
    
    override init(frame: CGRect) {
        if let viewFromNib = Content.loadDefaultNib() {
            content = viewFromNib
        }
        else {
            content = Content(frame: frame)
        }
        super.init(frame: frame)
        self.embedContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func embedContent() {
        ViewEmbedder.embed(self.content, in: self.contentView)
    }
    
}
