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
    fileprivate static let repository = GameRepository()
    
    func viewController() -> GameViewController {
        let viewController = GameViewController()
        viewController.presenter = self.presenter()
        return viewController
    }
    
    func presenter() -> GamePresenter {
        let presenter = GamePresenter()
        presenter.getGame = self.getGame()
        presenter.selectLetter = self.selectLetter()
        presenter.selectInputLetter = self.selectInputLetter()
        presenter.advanceToNextLevel = self.advanceToNextLevel()
        return presenter
    }
    
    func resetGameInteractor() -> ResetGame {
        let interactor = ResetGame()
        interactor.repository = self.gameRepository()
        interactor.saveGame = self.saveGame()
        return interactor
    }
    
    func gameRepository() -> GameRepository {
        return GameFactory.repository
    }
    
    func getGame() -> GetGame {
        let interactor = GetGame()
        interactor.repository = self.gameRepository()
        return interactor
    }
    
    func saveGame() -> SaveGame {
        let interactor = SaveGame()
        interactor.repository = self.gameRepository()
        return interactor
    }
    
    func selectLetter() -> SelectLetter {
        let interactor = SelectLetter()
        interactor.getGame = self.getGame()
        interactor.saveGame = self.saveGame()
        return interactor
    }
    
    func selectInputLetter() -> SelectInputLetter {
        let interactor = SelectInputLetter()
        interactor.getGame = self.getGame()
        interactor.saveGame = self.saveGame()
        return interactor
    }
    
    func advanceToNextLevel() -> AdvanceToNextLevel {
        let interactor = AdvanceToNextLevel()
        interactor.getGame = self.getGame()
        interactor.saveGame = self.saveGame()
        interactor.repository = self.gameRepository()
        return interactor
    }
    
}
