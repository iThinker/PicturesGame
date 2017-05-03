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
    
    func router() -> GameRouter {
        return GameRouter()
    }
    
    func viewController() -> GameViewController {
        let viewController = GameViewController()
        viewController.presenter = self.presenter()
        return viewController
    }
    
    func presenter() -> GamePresenter {
        let presenter = GamePresenter()
        presenter.router = self.router()
        presenter.getGame = self.getGame()
        presenter.selectLetter = self.selectLetter()
        presenter.selectInputLetter = self.selectInputLetter()
        presenter.advanceToNextLevel = self.advanceToNextLevel()
        presenter.resetGame = self.resetGameInteractor()
        presenter.promptRevealLetter = self.promptRevealLetter()
        presenter.promptRemoveInvalidLetters = self.promptRemoveInvalidLetters()
        presenter.userCurrencyPresenter = CurrencyFactory.shared.presenter()
        return presenter
    }
    
    func gameRepository() -> GameRepository {
        return GameFactory.repository
    }
    
    func resetGameInteractor() -> ResetGame {
        let interactor = ResetGame()
        interactor.repository = self.gameRepository()
        interactor.saveGame = self.saveGame()
        return interactor
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
        interactor.rewardForCompletingLevel = self.rewardForCompletingLevel()
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
    
    func promptRevealLetter() -> PromptRevealLetter {
        let interactor = PromptRevealLetter()
        interactor.getGame = self.getGame()
        interactor.saveGame = self.saveGame()
        interactor.userCurrency = CurrencyFactory.sharedUserCurrency
        interactor.rewardForCompletingLevel = self.rewardForCompletingLevel()
        return interactor
    }
    
    func promptRemoveInvalidLetters() -> PromptRemoveInvalidLetters {
        let interactor = PromptRemoveInvalidLetters()
        interactor.getGame = self.getGame()
        interactor.saveGame = self.saveGame()
        interactor.userCurrency = CurrencyFactory.sharedUserCurrency
        return interactor
    }
    
    func rewardForCompletingLevel() -> RewardPlayerForCompletingLevel {
        let interactor = RewardPlayerForCompletingLevel()
        interactor.userCurrency = CurrencyFactory.sharedUserCurrency
        return interactor
    }
    
}
