//
//  SelectInputLetter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-13.
//  Copyright © 2016 Temkos. All rights reserved.
//

import Foundation

class SelectInputLetter {
    
    var repository: GameRepository!
    
    func select(_ inputLetter: GameLevelEntity.InputLetter) {
        let game = self.repository.get()
        let level = game.currentLevel
        
        level?.remove(inputLetter)
        
        self.repository.save(game)
    }
    
}
