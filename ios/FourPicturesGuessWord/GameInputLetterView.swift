//
//  GameInputLetterView.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-17.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameInputLetterView: UIView {

    @IBOutlet fileprivate var button: UIButton!
    
    var inputLetter: GamePresenter.PresentableModel.InputModel! {
        didSet {
            if let letter = inputLetter.letter {
                self.button.isHidden = false
                self.button.setTitle(String(letter.character), for: .normal)
                let letterColor = inputLetter.inputLetter.isRevealed ? UIColor.green : UIColor.blue
                self.button.setTitleColor(letterColor, for: .normal)
            }
            else {
                self.button.isHidden = true
            }
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
