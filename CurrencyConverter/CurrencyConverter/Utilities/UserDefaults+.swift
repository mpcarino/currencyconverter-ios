//
//  UserDefaults+.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation

extension UserDefaults {
  static var hasUsedInitialWallets: Bool {
    get {
      UserDefaults.standard.bool(forKey: Constant.App.kHasUsedInitialWallets)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: Constant.App.kHasUsedInitialWallets)
    }
  }
}
