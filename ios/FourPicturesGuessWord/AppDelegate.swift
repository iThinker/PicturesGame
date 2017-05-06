//
//  AppDelegate.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-11.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let mainNavigator = MainNavigator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.configure()
        self.configureStubs()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.mainNavigator.show(in: self.window!)
        
        return true
    }
    
    fileprivate func configure() {
        self.configurePaymentObserving()
        self.configureProgressHUD()
    }
    
    fileprivate func configurePaymentObserving() {
        PaymentTransactionResultObserver.shared.userCurrency = CurrencyFactory.sharedUserCurrency
        PaymentTransactionResultObserver.shared.productRepository = ProductsFactory.shared.repository()
        PaymentQueueObserver.shared.startObserving()
    }
    
    fileprivate func configureProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    fileprivate func configureStubs() {
        CurrencyRepository.amount = 100
    }

}

