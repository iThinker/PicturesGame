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
        let vc = MainMenuViewController()
        let presenter = self.mainMenuPresenter()
        vc.presenter = presenter
        presenter.presentable = vc
        
        return vc
    }
    
    func mainMenuPresenter() -> MainMenuPresenter {
        let presenter = MainMenuPresenter()
        presenter.router = self.mainMenuRouter()
        presenter.resetGame = GameFactory.shared.resetGameInteractor()
        
        return presenter
    }
    
    func mainMenuRouter() -> MainMenuRouter {
        let router = MainMenuRouter()
        
        return router
    }
    
}
