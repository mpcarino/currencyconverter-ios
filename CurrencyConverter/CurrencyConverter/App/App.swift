//
//  App.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

final class App {
  static let shared = App()

  // MARK: - Properties

  private(set) var user: User
  private(set) var currencyDataService: CurrencyDataService!
  private(set) var supportedCurrencies: [Currency]

  // MARK: - Init

  init() {
    user = User()
    supportedCurrencies = []
  }
}

// MARK: - Methods

extension App {
  func bootstrap(
    with application: UIApplication,
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) {
    currencyDataService = CurrencyDataService()

    if UserDefaults.isFirstAppOpen {
      
    }
  }
}

class User {
  var wallets: [Wallet]

  init() {
    wallets = []

    wallets.append(.init(amount: 12345, currency: .init(locale: "en_US", code: "USD")))
  }
}
