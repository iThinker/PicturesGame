//
//  SelectInputLetter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-13.
//  Copyright © 2016 Temkos. All rights reserved.
//

import Foundation

class SelectInputLetter {
    
    var getGame: GetGame!
    var saveGame: SaveGame!
    
    func select(_ inputLetter: GameLevelEntity.InputLetter) -> GameLevelEntity.Letter? {
        let game = self.getGame.get()
        let level = game.currentLevel
        
        let result = level?.remove(inputLetter)
        
        self.saveGame.save(game)
        
        return result
    }
    
}
