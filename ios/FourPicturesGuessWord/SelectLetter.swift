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
        case success(GameLevelEntity.InputLetter)
        case successWrongWord(GameLevelEntity.InputLetter)
        case failureNoSpace
        case levelComplete(GameLevelEntity.InputLetter)
    }
    
    
    var getGame: GetGame!
    var saveGame: SaveGame!
    
    func select(_ letter: GameLevelEntity.Letter) -> Result {
        let game = self.getGame.get()
        let level = game.currentLevel!
        assert(level.isSolved == false)
        
        if level.hasFreeInput == false {
            return .failureNoSpace
        }
        
        let result = level.append(letter)
        self.saveGame.save(game)
        
        if level.isSolved {
            return .levelComplete(result)
        }
        
        if level.hasFreeInput == false {
            return .successWrongWord(result)
        }
        
        return .success(result)
    }
    
}
