//
//  ModalViewControllerContainer.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-05-02.
//  Copyright © 2017 Temkos. All rights reserved.
//

import UIKit

class ModalContainerViewController<Content: UIViewController>: UIViewController {
    
    var content: Content
    
    init(content: Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var navigationItem: UINavigationItem {
        return self.content.navigationItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ModalContainerViewController.cancel))
        self.embed(self.content, in: self.view)
    }
    
    func cancel() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
