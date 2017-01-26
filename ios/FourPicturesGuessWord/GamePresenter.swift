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
    func showLetterSelected(_ letter: GameLevelEntity.Letter, inputLetter: GamePresenter.PresentableModel.InputModel)
    func showInputLetterRemoved(_ inputLetter: GamePresenter.PresentableModel.InputModel, letter: GameLevelEntity.Letter)
}

class GamePresenter {
    
    class PresentableModel {
        
        class InputModel {
            
            var letter: GameLevelEntity.Letter?
            var inputLetter: GameLevelEntity.InputLetter!
            var index = 0
            
        }
        
        var images: [UIImage]!
        var letters: [GameLevelEntity.Letter]!
        var input: [InputModel]!
        var isWrongWord = false
        
    }
    
    var presentable: GamePresentable!
    var presentableModel: PresentableModel!
    
    var getGame: GetGame!
    var selectLetter: SelectLetter!
    var selectInputLetter: SelectInputLetter!
    var advanceToNextLevel: AdvanceToNextLevel!
    
    func startPresentation() {
        self.showCurrentLevel()
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
            self.syncPresentableModelState()
            let input = self.presentableModel.input.first(where: { $0.inputLetter === inputLetter})!
            self.presentable.showLetterSelected(letter, inputLetter: input)
            break
        case .successWrongWord(let inputLetter):
            self.syncPresentableModelState()
            self.presentableModel.isWrongWord = true
            let input = self.presentableModel.input.first(where: { $0.inputLetter === inputLetter})!
            self.presentable.showLetterSelected(letter, inputLetter: input)
            self.presentable.showNoInputSpaceLeft()
            break
        }
    }
    
    func select(_ input: GamePresenter.PresentableModel.InputModel) {
        if let inputLetter = input.inputLetter {
            let result = self.selectInputLetter.select(inputLetter)
            if let letter = result {
                self.syncPresentableModelState()
                let input = self.presentableModel.input.first(where: { $0.inputLetter === inputLetter})!
                self.presentable.showInputLetterRemoved(input, letter: letter)
            }
        }
    }
    
    func advanceToNextLevelAction() {
        self.advanceToNextLevel.advance()
        self.showCurrentLevel()
    }
    
    //MARK: Private
    
    fileprivate func showCurrentLevel() {
        let game = self.getGame.get()
        let level = game.currentLevel!
        self.presentableModel = PresentableModel()
        self.presentableModel.images = level.images.map({ UIImage(contentsOfFile: $0)! })
        self.updatePresentableModel(with: level)
        self.presentable.show(self.presentableModel)
    }
    
    fileprivate func syncPresentableModelState() {
        let game = self.getGame.get()
        let level = game.currentLevel!
        self.updatePresentableModel(with: level)
    }
    
    fileprivate func updatePresentableModel(with level: GameLevelEntity) {
        self.presentableModel.letters = level.availableLetters
        var i = 0
        self.presentableModel.input = level.inputLetters.map({ inputLetter -> PresentableModel.InputModel in
            let input = PresentableModel.InputModel()
            input.inputLetter = inputLetter
            input.letter = level.letter(for: inputLetter)
            input.index = i
            i += 1
            return input
        })
        self.presentableModel.isWrongWord = level.hasFreeInput == false
    }
    
}
