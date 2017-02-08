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
    
    func remove() {
        let game = self.getGame.get()
        let level = game.currentLevel
        
        
        
        self.saveGame.save(game)
    }
    
}
