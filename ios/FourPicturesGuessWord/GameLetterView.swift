//
//  GameLetterView.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-17.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameLetterView: UIView {

    @IBOutlet fileprivate var button: UIButton!
    @IBOutlet fileprivate var label: UILabel!
    
    var letter: GameLevelEntity.Letter! {
        didSet {
            self.label.text = String(letter.character)
            self.button.isHidden = letter.isSelected
            self.label.isHidden = letter.isSelected
        }
    }
    
    var onTap: (() -> Void)!

    @IBAction func tapAction(_ sender: Any) {
        self.onTap()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
}
