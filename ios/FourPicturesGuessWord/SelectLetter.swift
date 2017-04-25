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
        case levelComplete(GameLevelEntity, GameLevelEntity.InputLetter)
        case gameComplete(GameEntity, GameLevelEntity.InputLetter)
    }
    
    
    var getGame: GetGame!
    var saveGame: SaveGame!
    var rewardForCompletingLevel: RewardPlayerForCompletingLevel!
    
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
            self.rewardForCompletingLevel.reward()
            if game.isCurrentLevelLast {
                return .gameComplete(game, result)
            }
            else {
                return .levelComplete(level, result)
            }
        }
        
        if level.hasFreeInput == false {
            return .successWrongWord(result)
        }
        
        return .success(result)
    }
    
}
