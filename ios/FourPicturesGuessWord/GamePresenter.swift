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
    func showLevelComplete(levelNumber: Int)
    func showGameComplete()
    func showLetterSelected(_ letter: GameLevelEntity.Letter, inputLetter: GamePresenter.PresentableModel.InputModel)
    func showInputLetterRemoved(_ inputLetter: GamePresenter.PresentableModel.InputModel, letter: GameLevelEntity.Letter)
    func showInputLetterRevealed(_ inputLetter: GamePresenter.PresentableModel.InputModel)
    func showLetterSelected(_ letter: GameLevelEntity.Letter)
    func showLetterDeselected(_ letter: GameLevelEntity.Letter)
    func showInputLetterDeselected(_ inputLetter: GamePresenter.PresentableModel.InputModel)
    func showLetterRemoved(_ letter: GameLevelEntity.Letter)
    func showMessage(_ message: String)
}

class GamePresenter {
    
    class PresentableModel {
        
        class InputModel {
            
            var letter: GameLevelEntity.Letter?
            var inputLetter: GameLevelEntity.InputLetter!
            var isEnabled = true
            var index = 0
            
        }
        
        var images: [UIImage]!
        var letters: [GameLevelEntity.Letter]!
        var input: [InputModel]!
        var isWrongWord = false
        
    }
    
    weak var presentable: GamePresentable!
    var presentableModel: PresentableModel!
    
    var getGame: GetGame!
    var selectLetter: SelectLetter!
    var selectInputLetter: SelectInputLetter!
    var advanceToNextLevel: AdvanceToNextLevel!
    var resetGame: ResetGame!
    var promptRevealLetter: PromptRevealLetter!
    var promptRemoveInvalidLetters: PromptRemoveInvalidLetters!
    
    var onGameComplete: (() -> Void)!
    
    func startPresentation() {
        self.showCurrentLevel()
    }
    
    func select(_ letter: GameLevelEntity.Letter) {
        let result = self.selectLetter.select(letter)
        var resultInputLetter: GameLevelEntity.InputLetter?
        switch result {
        case .failureNoSpace:
            self.presentableModel.isWrongWord = true
            self.presentable.showNoInputSpaceLeft()
            break
        case .levelComplete(let level, let inputLetter):
            resultInputLetter = inputLetter
            self.presentable.showLevelComplete(levelNumber: level.index)
            break
        case .success(let inputLetter):
            resultInputLetter = inputLetter
            break
        case .successWrongWord(let inputLetter):
            self.presentableModel.isWrongWord = true
            resultInputLetter = inputLetter
            self.presentable.showNoInputSpaceLeft()
            break
        case .gameComplete(_, let inputLetter):
            resultInputLetter = inputLetter
            self.presentable.showGameComplete()
            break
        }
        
        if let inputLetter = resultInputLetter {
            self.syncPresentableModelState()
            let input = self.presentableModel(for: inputLetter)
            self.presentable.showLetterSelected(letter, inputLetter: input)
        }
    }
    
    func select(_ input: GamePresenter.PresentableModel.InputModel) {
        let inputLetter = input.inputLetter!
        let result = self.selectInputLetter.select(inputLetter)
        if let letter = result {
            self.syncPresentableModelState()
            let input = self.presentableModel(for: inputLetter)
            self.presentable.showInputLetterRemoved(input, letter: letter)
        }
    }
    
    func advanceToNextLevelAction() {
        self.advanceToNextLevel.advance()
        self.showCurrentLevel()
    }
    
    func promptRevealLetterAction() {
        let result = self.promptRevealLetter.reveal()
        self.syncPresentableModelState()
        result.affectedInputLetter.map({ self.presentable.showInputLetterDeselected(self.presentableModel(for: $0)) })
        result.affectedLetter.map({ self.presentable.showLetterDeselected($0) })
        self.presentable.showLetterSelected(result.revealedLetter)
        self.presentable.showInputLetterRevealed(self.presentableModel(for: result.revealedInputLetter))
        if result.isLevelSolved {
            let game = self.getGame.get()
            let level = game.currentLevel!
            if game.isCurrentLevelLast {
                self.presentable.showGameComplete()
            }
            else {
                self.presentable.showLevelComplete(levelNumber: level.index)
            }
        }
    }
    
    func promptRemoveInvalidLettersAction() {
        let game = self.getGame.get()
        let level = game.currentLevel!
        if level.canPromptRemoveInvalidLetters {
            let result = self.promptRemoveInvalidLetters.remove()
            self.syncPresentableModelState()
            result.affectedInputLetter.map({ self.presentable.showInputLetterDeselected(self.presentableModel(for: $0)) })
            self.presentable.showLetterRemoved(result.letter)
        }
        else {
            self.presentable.showMessage(NSLocalizedString("Cannot remove any letter", comment: ""))
        }
    }
    
    func finishGameAction() {
        self.resetGame.reset()
        self.onGameComplete()
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
            input.isEnabled = !inputLetter.isRevealed
            input.index = i
            i += 1
            return input
        })
        self.presentableModel.isWrongWord = level.hasFreeInput == false
    }
    
    fileprivate func presentableModel(for inputLetter: GameLevelEntity.InputLetter) -> PresentableModel.InputModel {
        return self.presentableModel.input.first(where: { $0.inputLetter === inputLetter})!
    }
    
}
