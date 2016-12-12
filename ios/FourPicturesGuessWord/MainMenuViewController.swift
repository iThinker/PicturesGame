//
//  MainMenuViewController.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, MainMenuPresentable {

    var presenter: MainMenuPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.startPresentation()
    }
    
    @IBAction func continueGameAction(_ sender: Any) {
        self.presenter.continueGame()
    }
    
    @IBAction func newGameAction(_ sender: Any) {
        self.presenter.startNewGame()
    }

}
