//
//  SaveGame.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-15.
//  Copyright © 2016 Temkos. All rights reserved.
//

import Foundation

class SaveGame {
    
    var repository: GameRepository!
    
    func save(_ game: GameEntity) {
        self.repository.save(game)
    }
    
}
