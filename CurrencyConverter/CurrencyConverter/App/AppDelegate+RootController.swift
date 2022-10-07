//
//  AppDelegate+RootController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation

extension AppDelegate {
    func updateRootController() {
        setRootToConvert()
    }
    
    func setRootToConvert() {
        let controller = R.storyboard.convert.instantiateInitialViewController()
        window?.rootViewController = controller
    }
}
