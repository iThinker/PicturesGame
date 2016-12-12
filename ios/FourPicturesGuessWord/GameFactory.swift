//
//  GameFactory.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameFactory {
    
    static let shared = GameFactory()
    fileprivate let repository = GameRepository()
    
    func resetGameInteractor() -> ResetGame {
        let interactor = ResetGame()
        interactor.repository = self.gameRepository()
        return interactor
    }
    
    func gameRepository() -> GameRepository {
        return self.repository
    }
    
}
