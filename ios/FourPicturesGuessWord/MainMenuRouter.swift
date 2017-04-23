//
//  MainMenuRouter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class MainMenuRouter {
    
    var navigationController: UINavigationController!
    
    func navigateToGame() {
        let viewController = GameFactory.shared.viewController()
        viewController.presenter.onGameComplete = {
            self.navigationController.isNavigationBarHidden = true
            self.navigationController.popViewController(animated: true)
        }
        self.navigationController.isNavigationBarHidden = false
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
