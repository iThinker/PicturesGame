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
    
    var index: [[String: String]] = []
    
    init() {
        self.loadLevelIndex()
    }
    
    func save(_ game: GameEntity) {
        GameRepository.game = game
    }
    
    func get() -> GameEntity {
        return GameRepository.game
    }
    
    func getLevel(at index: Int) -> GameLevelEntity {
        assert(index < self.getTotalLevelCount())
        
        return self.levelAt(index: index)
    }
    
    func getTotalLevelCount() -> Int {
        return self.index.count
    }
    
    fileprivate func loadLevelIndex() {
        let path = Bundle.main.path(forResource: "index", ofType: "json", inDirectory: "Levels")
        let data = FileManager.default.contents(atPath: path!)
        let index = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String : String]]
        self.index = index
    }
    
    fileprivate func levelAt(index: Int) -> GameLevelEntity {
        let level = GameLevelEntity()
        let levelDict = self.index[index]
        
        level.availableLetters = levelDict["letters"]!.characters.map({ character -> GameLevelEntity.Letter in
            let letter = GameLevelEntity.Letter()
            letter.character = character
            return letter
        })
        level.solutionWord = levelDict["solution"]
        level.inputLetters = level.solutionWord.characters.map({ _ in return GameLevelEntity.InputLetter() })
        level.index = index
        
        var images: [String] = []
        let directory = "Levels/\(index)"
        for i in 0...3 {
            let path = Bundle.main.path(forResource: "\(i)", ofType: "png", inDirectory: directory)
            images.append(path!)
        }
        level.images = images
        
        return level
    }
    
}
