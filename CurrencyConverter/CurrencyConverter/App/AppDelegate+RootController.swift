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
        setRootToConvert()
    }
    
    func setRootToConvert() {
        let controller = R.storyboard.convert.convertController()!
        window?.rootViewController = UINavigationController(rootViewController: controller)
    }
}
