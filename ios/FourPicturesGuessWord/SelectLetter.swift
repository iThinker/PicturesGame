//
//  SelectLetter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-13.
//  Copyright © 2016 Temkos. All rights reserved.
//

import Foundation

class SelectLetter {
    
    enum Result {
        case success
        case successWrongWord
        case failureNoSpace
        case levelComplete
    }
    
    var repository: GameRepository!
    
    func select(_ letter: GameLevelEntity.Letter) -> Result {
        let game = self.repository.get()
        let level = game.currentLevel!
        assert(level.isSolved == false)
        
        if level.hasFreeInput == false {
            return .failureNoSpace
        }
        
        level.append(letter)
        self.repository.save(game)
        
        if level.isSolved {
            return .levelComplete
        }
        
        if level.hasFreeInput == false {
            return .successWrongWord
        }
        
        return .success
    }
    
}
