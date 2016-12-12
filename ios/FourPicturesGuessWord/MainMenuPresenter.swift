//
//  MainMenuPresenter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

protocol MainMenuPresentable: class {
    
}

class MainMenuPresenter {
    
    weak var presentable: MainMenuPresentable!
    var router: MainMenuRouter!
    var resetGame: ResetGame!
    
    func startPresentation() {
        
    }
    
    func continueGame() {
        self.router.navigateToGame()
    }
    
    func startNewGame() {
        self.resetGame.reset()
        self.router.navigateToGame()
    }
    
}
