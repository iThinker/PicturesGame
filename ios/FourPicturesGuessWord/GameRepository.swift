//
//  GameRepository.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameRepository {

    static var game: GameEntity = {
        let game = GameEntity()
        game.currentLevel = GameRepository().getLevel(at: 0)
        return game
    }()
    
    func save(_ game: GameEntity) {
        GameRepository.game = game
    }
    
    func get() -> GameEntity {
        return GameRepository.game
    }
    
    func getLevel(at index: Int) -> GameLevelEntity {
        assert(index < self.getTotalLevelCount())
        
        let level = GameLevelEntity()
        
        level.availableLetters = "abcdefghijkl".characters.map({ character -> GameLevelEntity.Letter in
            let letter = GameLevelEntity.Letter()
            letter.character = character
            return letter
        })
        level.solutionWord = "abc"
        level.inputLetters = level.solutionWord.characters.map({ _ in return GameLevelEntity.InputLetter() })
        level.index = index
        
        level.images = ["stub0", "stub1", "stub0", "stub1"]
        
        return level
    }
    
    func getTotalLevelCount() -> Int {
        return 2
    }
    
}
