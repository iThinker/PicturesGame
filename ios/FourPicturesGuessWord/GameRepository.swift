//
//  GameRepository.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameRepository {

    static var game: GameEntity = GameEntity()
    
    func save(_ game: GameEntity) {
        GameRepository.game = game
    }
    
    func get() -> GameEntity {
        return GameRepository.game
    }
    
}
