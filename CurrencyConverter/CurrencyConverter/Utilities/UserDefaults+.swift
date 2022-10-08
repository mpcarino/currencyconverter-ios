//
//  UserDefaults+.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation

extension UserDefaults {
    static var isFirstAppOpen: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constant.App.kFirstAppOpen)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Constant.App.kFirstAppOpen)
        }
    }
}
