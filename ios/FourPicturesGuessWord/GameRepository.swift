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
        game.numberOfLevels = GameRepository.levelIndex.count
        if let savedGameState = UserDefaults.standard.dictionary(forKey: "savedGameState") {
            let levelNumber = savedGameState["levelNumber"] as! Int
            let level: GameLevelEntity = GameRepository().getLevel(at: levelNumber)
            let savedInput = savedGameState["input"] as! [[String: Any]]
            level.inputLetters = savedInput.map({ dict -> GameLevelEntity.InputLetter in
                let letter = GameLevelEntity.InputLetter()
                let index = dict["letterIndex"] as! Int
                letter.letterIndex = index == -1 ? nil : index
                letter.isRevealed = dict["isRevealed"] as! Bool
                return letter
            })
            level.inputLetters.forEach({ inputLetter in
                let letter = level.letter(for: inputLetter)
                letter?.isSelected = true
            })
            game.currentLevel = level
        }
        else {
            game.currentLevel = GameRepository().getLevel(at: 0)
        }
        return game
    }()
    
    static let levelIndex: [[String: String]] = {
        let path = Bundle.main.path(forResource: "index", ofType: "json", inDirectory: "Levels")
        let data = FileManager.default.contents(atPath: path!)
        let index = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String : String]]
        return index
    }()
    
    var index: [[String: String]] {
        return GameRepository.levelIndex
    }
    
    func save(_ game: GameEntity) {
        var currentStateDict: [String: Any] = [:]
        let level = game.currentLevel!
        currentStateDict["levelNumber"] = level.index
        currentStateDict["input"] = level.inputLetters.map({ return ["letterIndex": $0.letterIndex ?? -1,
                                                                     "isRevealed": $0.isRevealed] })
        UserDefaults.standard.set(currentStateDict, forKey: "savedGameState")
        UserDefaults.standard.synchronize()
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
    
    func newGame() -> GameEntity {
        let game = GameEntity()
        game.numberOfLevels = self.index.count
        game.currentLevel = self.getLevel(at: 0)
        return game
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
