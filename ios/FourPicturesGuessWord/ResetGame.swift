//
//  ResetGame.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class ResetGame {

    var repository: GameRepository!
    
    func reset() {
        let game = GameEntity()
        self.repository.save(game)
    }
    
}
