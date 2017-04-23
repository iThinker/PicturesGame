//
//  PromptRemoveInvalidLetters.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-02-06.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class PromptRemoveInvalidLetters {
    
    var getGame: GetGame!
    var saveGame: SaveGame!
    var userCurrency: UserCurrency!
    
    let cost = 30
    
    struct Result {
        
        var letter: GameLevelEntity.Letter
        var affectedInputLetter: GameLevelEntity.InputLetter?
        
    }
    
    func remove() throws -> Result {
        try self.payForPrompt()
        let game = self.getGame.get()
        let result = self.removeLetter(in: game)
        self.saveGame.save(game)
        
        return result
    }
    
    fileprivate func payForPrompt() throws {
        try self.userCurrency.substractAmount(self.cost)
    }
    
    fileprivate func removeLetter(in game: GameEntity) -> Result {
        
        let level = game.currentLevel!
        
        let unrevealedCharacters = NSCountedSet()
        level.solutionWord.characters.forEach { (character) in
            unrevealedCharacters.add(character)
        }
        level.inputLetters
            .filter({ $0.isRevealed == true })
            .forEach {
                inputLetter in
                unrevealedCharacters.remove(level.letter(for: inputLetter)!.character)
        }
        var unrevealedLetters = self.filterRevealedLetters(in: level)
        unrevealedLetters.removeAll { $0.isRemoved }
        level.inputLetters
            .filter({ $0.isRevealed == false })
            .flatMap({ level.letter(for: $0) })
            .forEach {
                (letter) in
                if unrevealedCharacters.contains(letter.character) {
                    unrevealedCharacters.remove(letter.character)
                    unrevealedLetters.removeAll(of: letter)
                }
        }
        var letterToRemove: GameLevelEntity.Letter? = nil
        while letterToRemove == nil {
            let index = Int(arc4random_uniform(UInt32(unrevealedLetters.count)))
            let letter = unrevealedLetters[index]
            if unrevealedCharacters.contains(letter.character) {
                unrevealedCharacters.remove(letter.character)
                unrevealedLetters.removeAll(of: letter)
            }
            else {
                letterToRemove = letter
                break
            }
        }
        letterToRemove?.isRemoved = true
        
        let letterIndex = level.index(of: letterToRemove!)
        let affectedInputLetter = level.inputLetters.first(where: { $0.letterIndex == letterIndex })
        affectedInputLetter?.letterIndex = nil
        
        return Result(letter: letterToRemove!,
                      affectedInputLetter: affectedInputLetter)
    }
    
    fileprivate func filterRevealedLetters(in level: GameLevelEntity) -> [GameLevelEntity.Letter] {
        var availableLetters = level.availableLetters!
        var indicesToRemove = IndexSet()
        level.inputLetters.filter({ $0.isRevealed }).forEach({ indicesToRemove.insert($0.letterIndex!) })
        availableLetters.remove(at: indicesToRemove)
        return availableLetters
    }
    
}
