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
    var saveGame: SaveGame!
    
    func reset() {
        let game = self.repository.newGame()
        self.saveGame.save(game)
    }
    
}
