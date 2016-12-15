//
//  GameLevelEntity.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-12.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameLevelEntity {

    class Letter {
        
        var character: Character!
        var selected = false
        
    }
    
    class InputLetter {
        
        var letter: Letter?
        
        var isEmpty: Bool {
            return self.letter == nil
        }
        
    }
    
    var index: Int!
    var availableLetters: [Letter]!
    var inputLetters: [InputLetter]!
    var solutionWord: String!
    var images: [String]!
    
    var hasFreeInput: Bool {
        return self.inputLetters.first(where: { $0.isEmpty == true }) != nil
    }
    
    var isSolved: Bool {
        return self.solutionWord == self.inputWord
    }
    
    func append(_ letter: Letter) {
        assert(self.hasFreeInput == true)
        for inputLetter in self.inputLetters {
            if inputLetter.isEmpty {
                inputLetter.letter = letter
                break
            }
        }
        letter.selected = true
    }
    
    func remove(_ inputLetter: InputLetter) {
        inputLetter.letter?.selected = false
        inputLetter.letter = nil
    }
    
    fileprivate var inputWord: String {
        return self.inputLetters.flatMap { $0.letter }.map { String($0.character) }.reduce("", +)
    }
    
}
