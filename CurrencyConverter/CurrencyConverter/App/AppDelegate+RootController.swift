//
//  AppDelegate+RootController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

extension AppDelegate {
    func updateRootController() {
        setRootToWallet()
    }
    
    func setRootToWallet() {
        let controller = R.storyboard.wallet.instantiateInitialViewController()
        window?.rootViewController = controller
    }
}
