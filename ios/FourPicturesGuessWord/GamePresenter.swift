//
//  GamePresenter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-12.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

protocol GamePresentable: class {
    func show(_ presentableModel: GamePresenter.PresentableModel)
    func showNoInputSpaceLeft()
    func showLevelComplete()
    func showLetterSelected(_ letter: GameLevelEntity.Letter, inputLetter: GameLevelEntity.InputLetter)
    func showInputLetterRemoved(_ inputLetter: GameLevelEntity.InputLetter, letter: GameLevelEntity.Letter)
}

class GamePresenter {
    
    class PresentableModel {
        
        var images: [UIImage]!
        var letters: [GameLevelEntity.Letter]!
        var inputLetters: [GameLevelEntity.InputLetter]!
        var isWrongWord = false
        
    }
    
    var presentable: GamePresentable!
    var presentableModel: PresentableModel!
    
    var getGame: GetGame!
    var selectLetter: SelectLetter!
    var selectInputLetter: SelectInputLetter!
    
    func startPresentation() {
        let game = self.getGame.get()
        let level = game.currentLevel!
        self.presentableModel = PresentableModel()
        self.presentableModel.images = level.images.map({ UIImage(named: $0)! })
        self.updatePresentableModel(with: level)
        self.presentable.show(presentableModel)
    }
    
    func select(_ letter: GameLevelEntity.Letter) {
        let result = self.selectLetter.select(letter)
        switch result {
        case .failureNoSpace:
            self.presentableModel.isWrongWord = true
            self.presentable.showNoInputSpaceLeft()
            break
        case .levelComplete:
            self.presentable.showLevelComplete()
            break
        case .success(let inputLetter):
            self.presentable.showLetterSelected(letter, inputLetter: inputLetter)
        case .successWrongWord(let inputLetter):
            self.presentableModel.isWrongWord = true
            self.presentable.showLetterSelected(letter, inputLetter: inputLetter)
            self.presentable.showNoInputSpaceLeft()
        }
        self.syncPresentableModelState()
    }
    
    func select(_ inputLetter: GameLevelEntity.InputLetter) {
        let result = self.selectInputLetter.select(inputLetter)
        if let letter = result {
            self.presentable.showInputLetterRemoved(inputLetter, letter: letter)
        }
    }
    
    func advanceToNextLevel() {
        
    }
    
    //MARK: Private
    
    fileprivate func syncPresentableModelState() {
        let game = self.getGame.get()
        let level = game.currentLevel!
        self.updatePresentableModel(with: level)
    }
    
    fileprivate func updatePresentableModel(with level: GameLevelEntity) {
        self.presentableModel.letters = level.availableLetters
        self.presentableModel.inputLetters = level.inputLetters
        self.presentableModel.isWrongWord = level.hasFreeInput == false
    }
    
}
