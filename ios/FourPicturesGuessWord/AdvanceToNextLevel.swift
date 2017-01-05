//
//  AdvanceToNextLevel.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-01-04.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class AdvanceToNextLevel {
    
    var getGame: GetGame!
    var saveGame: SaveGame!
    var repository: GameRepository!
    
    func advance() -> Void {
        let game = self.getGame.get()
        let currentLevel = game.currentLevel!
        let nextLevel = self.repository.getLevel(at: currentLevel.index)
        game.currentLevel = nextLevel
        self.saveGame.save(game)
    }
    
}
