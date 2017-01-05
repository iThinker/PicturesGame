//
//  GameViewController.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-16.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var imagesContainerView: UIView!
    @IBOutlet var inputContainerView: UIView!
    @IBOutlet var lettersContainerView: UIView!
    
    fileprivate var imagesView: GameImagesView!
    fileprivate var lettersInputView: GameInputView!
    fileprivate var lettersView: GameLettersView!
    
    var presenter: GamePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureImagesView()
        self.configureInputView()
        self.configureLettersView()
        
        self.presenter.presentable = self
        self.presenter.startPresentation()
    }
    
    fileprivate func configureImagesView() {
        self.imagesView = GameImagesView.loadDefaultNib()!
        self.imagesContainerView.embed(self.imagesView)
    }
    
    fileprivate func configureInputView() {
        self.lettersInputView = GameInputView.loadDefaultNib()!
        self.lettersInputView.didSelectLetter = {
            [unowned self]
            letter in
            self.presenter.select(letter)
        }
        self.inputContainerView.embed(self.lettersInputView)
    }
    
    fileprivate func configureLettersView() {
        self.lettersView = GameLettersView.loadDefaultNib()!
        self.lettersView.didSelectLetter = {
            [unowned self]
            letter in
            self.presenter.select(letter)
        }
        self.lettersContainerView.embed(self.lettersView)
    }
    
}

extension GameViewController: GamePresentable {
    
    func show(_ presentableModel: GamePresenter.PresentableModel) {
        self.imagesView.showImages(presentableModel.images)
        self.lettersView.letters = presentableModel.letters
        self.lettersInputView.input = presentableModel.inputLetters
    }
    
    func showNoInputSpaceLeft() {
        print("No Input \n")
    }
    
    func showLevelComplete() {
        self.presenter.advanceToNextLevelAction()
    }
    
    func showLetterSelected(_ letter: GameLevelEntity.Letter, inputLetter: GameLevelEntity.InputLetter) {
        self.lettersView.letterUpdated(letter)
        self.lettersInputView.inputUpdated(inputLetter)
    }
    
    func showInputLetterRemoved(_ inputLetter: GameLevelEntity.InputLetter, letter: GameLevelEntity.Letter) {
        self.lettersView.letterUpdated(letter)
        self.lettersInputView.inputUpdated(inputLetter)
    }
    
}
