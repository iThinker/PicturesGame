//
//  MainNavigator.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class MainNavigator {

    fileprivate var window: UIWindow!
    fileprivate var navigationController: UINavigationController!
    
    func show(in window: UIWindow) {
        self.window = window
        self.showMainMenu()
    }
    
    fileprivate func showMainMenu() {
        let viewController = MainMenuFactory.shared.mainMenuViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        navigationController.navigationBar.isTranslucent = false
        self.navigationController = navigationController
        let router = MainMenuRouter()
        router.navigationController = navigationController
        viewController.presenter.router = router
        self.window.rootViewController = navigationController
    }
    
}
