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
  private(set) var user: User
  private(set) var supportedCurrencies: [Currency]

  private(set) var currencyExchangeService: CurrencyExchangeServiceProtocol!
  private(set) var supportedCurrencyDataService: JSONDataService<[Currency]>!
  private(set) var walletDataService: JSONDataService<[Wallet]>!

  // MARK: - Init

  init() {
    user = User(wallets: [])
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
    supportedCurrencyDataService = JSONDataService<[Currency]>(decoder: config.jsonDecoder)
    walletDataService = JSONDataService<[Wallet]>(decoder: config.jsonDecoder)

    loadSupportedCurrencies()

    if !UserDefaults.hasUsedInitialWallets {
      loadInitialUserWallet()
    }
  }
}

// MARK: - Helpers

private extension App {
  func loadSupportedCurrencies() {
    guard let supportedCurrencies = supportedCurrencyDataService.load(fileName: config.supportedCurrenciesFileName) else {
      return
    }

    self.supportedCurrencies = supportedCurrencies
  }

  func loadInitialUserWallet() {
    guard let wallets = walletDataService.load(fileName: config.initialUserWalletsFileName) else {
      return
    }
    
    wallets.forEach({ user.addWallet($0) })
  }
}

class User {
  struct Notification { }
  
  // MARK: - Properties
  
  private(set) var wallets: [Wallet]
  
  // MARK: - Init
  
  init(wallets: [Wallet]) {
    self.wallets = wallets
  }
  
  // MARK: - Methods
  func addWallet(_ wallet: Wallet) {
    wallets.append(wallet)
  }
  
  func removeWallet(_ wallet: Wallet) {
    guard let index = wallets.firstIndex(where: {
      $0.currency == wallet.currency
    }) else { return }
    
    wallets.remove(at: index)
  }
  
  func updateWallets(with wallet: Wallet) {
    guard let index = wallets.firstIndex(where: {
      $0.currency == wallet.currency
    }) else { return }
    
    wallets[index] = wallet
    
    NotificationCenter.default.post(name: Notification.didUpdateWallets, object: nil)
  }
}

// MARK: - Notifications

extension User.Notification {
  static let didUpdateWallets = Notification.Name(rawValue: "notification.name.user.didUpdateWallets")
}
