//
//  GameImagesView.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-17.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameImagesView: UIView {
    
    @IBOutlet var imageView0: UIImageView!
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!

    var imageViews: [UIImageView] {
        return [imageView0, imageView1, imageView2, imageView3]
    }
    
    func showImages(_ images: [UIImage]) {
        let imageViews = self.imageViews
        for i in 0..<images.count {
            imageViews[i].image = images[i]
        }
    }
    
}
