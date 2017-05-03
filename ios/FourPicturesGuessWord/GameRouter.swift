//
//  GameRouter.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-05-02.
//  Copyright © 2017 Temkos. All rights reserved.
//

import UIKit

class GameRouter {
    
    var navigationController: UINavigationController!
    
    func showProductList() {
        let viewController = ProductsFactory.shared.listViewController()
        let containerViewController = ModalContainerViewController(content: viewController)
        let modalNavigationController = UINavigationController(rootViewController: containerViewController)
        modalNavigationController.navigationBar.isTranslucent = false
        self.navigationController.present(modalNavigationController, animated: true, completion: nil)
    }
    
}
