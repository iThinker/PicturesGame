//
//  GameViewController.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-16.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit
import SVProgressHUD

class GameViewController: UIViewController {
    
    @IBOutlet var imagesContainerView: UIView!
    @IBOutlet var inputContainerView: UIView!
    @IBOutlet var lettersContainerView: UIView!
    
    fileprivate var imagesView: GameImagesView!
    fileprivate var lettersInputView: GameInputView!
    fileprivate var lettersView: GameLettersView!
    fileprivate var userCurrencyView = UserCurrencyView.loadDefaultNib()!
    
    var presenter: GamePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureImagesView()
        self.configureInputView()
        self.configureLettersView()
        self.navigationItem.titleView = self.userCurrencyView
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.presenter.presentable = self
        self.presenter.startPresentation()
    }
    
    @IBAction func promptRevealLetterAction(_ sender: AnyObject) {
        self.presenter.promptRevealLetterAction()
    }
    
    @IBAction func promptRemoveInvalidLettersAction(_ sender: AnyObject) {
        self.presenter.promptRemoveInvalidLettersAction()
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
    
    func showInputLetterDeselected(_ inputLetter: GamePresenter.PresentableModel.InputModel) {
        self.lettersInputView.inputUpdated(inputLetter)
    }
    
    func show(userCurrencyPresenter: UserCurrencyPresenter) {
        self.userCurrencyView.show(userCurrencyPresenter)
    }

    func showLetterRemoved(_ letter: GameLevelEntity.Letter) {
        self.lettersView.letterUpdated(letter)
    }

    func showLetterDeselected(_ letter: GameLevelEntity.Letter) {
        self.lettersView.letterUpdated(letter)
    }

    func showLetterSelected(_ letter: GameLevelEntity.Letter) {
        self.lettersView.letterUpdated(letter)
    }
    
    func showInputLetterRevealed(_ inputLetter: GamePresenter.PresentableModel.InputModel) {
        self.lettersInputView.inputUpdated(inputLetter)
    }
    
    func show(_ presentableModel: GamePresenter.PresentableModel) {
        self.imagesView.showImages(presentableModel.images)
        self.lettersView.letters = presentableModel.letters
        self.lettersInputView.input = presentableModel.input
    }
    
    func showNoInputSpaceLeft() {
        self.showMessage(NSLocalizedString("No Input space left", comment: ""))
    }
    
    func showLevelComplete(levelNumber: Int) {
        let alert = UIAlertController(title: "Congratulations", message: "Level \(levelNumber) complete!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
            [weak self]
            _ in
            self?.presenter.advanceToNextLevelAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLetterSelected(_ letter: GameLevelEntity.Letter, inputLetter: GamePresenter.PresentableModel.InputModel) {
        self.lettersView.letterUpdated(letter)
        self.lettersInputView.inputUpdated(inputLetter)
    }
    
    func showInputLetterRemoved(_ inputLetter: GamePresenter.PresentableModel.InputModel, letter: GameLevelEntity.Letter) {
        self.lettersView.letterUpdated(letter)
        self.lettersInputView.inputUpdated(inputLetter)
    }
    
    func showGameComplete() {
        let alert = UIAlertController(title: "Congratulations", message: "Game complete!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
            [weak self]
            _ in
            self?.presenter.finishGameAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(_ message: String) {
        SVProgressHUD.showInfo(withStatus: message)
    }
    
    func showError(_ error: Error) {
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
    
}
