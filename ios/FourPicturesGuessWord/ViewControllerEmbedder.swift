//
//  ViewControllerEmbedder.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-30.
//  Copyright © 2017 Temkos. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func embed(_ viewController: UIViewController, in containerView: UIView) {
        self.addChildViewController(viewController)
        viewController.beginAppearanceTransition(true, animated: false)
        containerView.embed(viewController.view)
        viewController.endAppearanceTransition()
        viewController.didMove(toParentViewController: self)
    }
    
}
