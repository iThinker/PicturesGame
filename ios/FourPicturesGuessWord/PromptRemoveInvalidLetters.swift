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
    
    struct Result {
        
        var letter: GameLevelEntity.Letter
        var affectedInputLetter: GameLevelEntity.InputLetter?
        
    }
    
    func remove() -> Result {
        let game = self.getGame.get()
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
        unrevealedLetters = unrevealedLetters.sorted {
            letter1, letter2 in
            if letter1.isSelected == letter2.isSelected {
                return unrevealedLetters.index(where: { $0 === letter2 })! >
                    unrevealedLetters.index(where: { $0 === letter1 })!
            }
            else {
                return !(letter1.isSelected && !letter2.isSelected)
            }
        }
        var letterToRemove: GameLevelEntity.Letter? = nil
        for letter in unrevealedLetters {
            let character = letter.character!
            if unrevealedCharacters.contains(character) {
                unrevealedCharacters.remove(character)
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
        
        self.saveGame.save(game)
        
        return Result(letter: letterToRemove!,
                      affectedInputLetter: affectedInputLetter)
    }
    
    func filterRevealedLetters(in level: GameLevelEntity) -> [GameLevelEntity.Letter] {
        var availableLetters = level.availableLetters!
        var indicesToRemove = IndexSet()
        level.inputLetters.filter({ $0.isRevealed }).forEach({ indicesToRemove.insert($0.letterIndex!) })
        availableLetters.remove(at: indicesToRemove)
        return availableLetters
    }
    
}
