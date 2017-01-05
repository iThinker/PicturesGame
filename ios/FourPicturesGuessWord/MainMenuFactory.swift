//
//  MainMenuFactory.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class MainMenuFactory {
    static let shared = MainMenuFactory()
    
    func mainMenuViewController() -> MainMenuViewController {
        let viewController = MainMenuViewController()
        let presenter = self.mainMenuPresenter()
        viewController.presenter = presenter
        
        return viewController
    }
    
    func mainMenuPresenter() -> MainMenuPresenter {
        let presenter = MainMenuPresenter()
        presenter.resetGame = GameFactory.shared.resetGameInteractor()
        
        return presenter
    }
    
}
