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
        var isSelected = false
        var isRemoved = false
        
    }
    
    class InputLetter {
        
        var letterIndex: Int?
        var isRevealed = false
        
        var isEmpty: Bool {
            return self.letterIndex == nil
        }
        
    }
    
    static let MaxInputLength = 8
    
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
    
    var canPromptRemoveInvalidLetters: Bool {
        return self.availableLetters.filter({ $0.isRemoved == false }).count > self.inputLetters.count
    }
    
    func append(_ letter: Letter) -> InputLetter {
        assert(self.hasFreeInput == true)
        letter.isSelected = true
        for inputLetter in self.inputLetters {
            if inputLetter.isEmpty {
                inputLetter.letterIndex = self.index(of: letter)
                return inputLetter
            }
        }
        fatalError()
    }
    
    func remove(_ inputLetter: InputLetter) -> Letter? {
        let letter = self.letter(for: inputLetter)
        letter?.isSelected = false
        inputLetter.letterIndex = nil
        return letter
    }
    
    func letter(for inputLetter: InputLetter) -> Letter? {
        return inputLetter.letterIndex == nil ? nil : self.availableLetters[inputLetter.letterIndex!]
    }
    
    func index(of letter: Letter) -> Int {
        return self.availableLetters.index(where: { arrayLetter -> Bool in
            return arrayLetter === letter
        })!
    }
    
    fileprivate var inputWord: String {
        return self.inputLetters.flatMap { self.letter(for: $0) }.map { String($0.character) }.reduce("", +)
    }
    
}
