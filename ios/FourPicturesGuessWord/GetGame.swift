//
//  GetGame.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-15.
//  Copyright © 2016 Temkos. All rights reserved.
//

import Foundation

class GetGame {

    var repository: GameRepository!
    
    func get() -> GameEntity {
        return self.repository.get()
    }
    
}
