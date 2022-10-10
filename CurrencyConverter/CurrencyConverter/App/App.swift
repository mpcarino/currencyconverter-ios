//
//  App.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

import IQKeyboardManagerSwift

final class App {
  static let shared = App()

  // MARK: - Properties

  private(set) var config: AppConfigProtocol!
  private(set) var currencyExchangeService: CurrencyExchangeServiceProtocol!
  private(set) var supportedCurrencyService: SupportedCurrencyService!
  
  private(set) var user: User
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
    config = AppConfig()
    currencyExchangeService = CurrencyExchangeService()
    supportedCurrencyService = SupportedCurrencyService()
    
    loadSupportedCurrencies()
  }
}

// MARK: - Helpers

private extension App {
  func loadSupportedCurrencies() {
    guard let supportedCurrencies = supportedCurrencyService.load() else {
      return
    }
    
    self.supportedCurrencies = supportedCurrencies
  }
}

class User {
  var wallets: [Wallet]

  init() {
    wallets = []

    wallets.append(.init(balance: 12345, currency: .init(locale: "en_US", code: "USD")))
    wallets.append(.init(balance: 12345, currency: .init(locale: "es_ES", code: "EUR")))
    wallets.append(.init(balance: 12345, currency: .init(locale: "ja_JP", code: "JPY")))
  }
}
