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
    
    func show(in window: UIWindow) {
        self.window = window
        self.window.rootViewController = MainMenuFactory.shared.mainMenuViewController()
    }
    
}
