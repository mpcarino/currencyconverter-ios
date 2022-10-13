
//
//  App.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import CoreData
import Foundation
import UIKit

import IQKeyboardManagerSwift

final class App {
  static let shared = App()

  // MARK: - Properties

  private(set) var supportedCurrencies: [Currency]
  private(set) var currencyExchangeRules: [CurrencyExchangeRule]

  private(set) var config: ConfigurationProtocol!
  private(set) var session: Session!

  private(set) var supportedCurrencyJSONService: JSONDataService<[Currency]>!
  private(set) var walletJSONService: JSONDataService<[Wallet]>!
  private(set) var currencyExchangeRuleJSONService: JSONDataService<[CurrencyExchangeRule]>!

  private(set) var currencyExchangeService: CurrencyExchangeServiceProtocol!
  private(set) var currencyExchangeRuleService: CurrencyExchangeRuleServiceProtocol!
  private(set) var walletService: WalletService!
  private(set) var transactionService: TransactionService!

  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CurrencyConverter")
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    
    return container
  }()

  // MARK: - Init

  init() {
    supportedCurrencies = []
    currencyExchangeRules = []
  }
}

// MARK: - Methods

extension App {
  func bootstrap(
    with application: UIApplication,
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) {
    config = AppConfiguration()
    
    supportedCurrencyJSONService = JSONDataService<[Currency]>(decoder: config.jsonDecoder)
    walletJSONService = JSONDataService<[Wallet]>(decoder: config.jsonDecoder)
    currencyExchangeRuleJSONService = JSONDataService<[CurrencyExchangeRule]>(decoder: config.jsonDecoder)
    
    loadSupportedCurrencies()
    loadCurrencyExchangeRules()

    currencyExchangeService = CurrencyExchangeService()
    currencyExchangeRuleService = CurrencyExchangeRuleService(persistentContainer: persistentContainer)
    walletService = WalletService(persistentContainer: persistentContainer)
    transactionService = TransactionService(persistentContainer: persistentContainer)

    session = Session(
      user: User(
        wallets: [],
        transactions: []
      )
    )
    
    saveInitialWallets()
  }
}

// MARK: - Helpers

private extension App {
  ///
  ///  Load supported currencies defined in a JSON file
  ///
  func loadSupportedCurrencies() {
    guard let supportedCurrencies = supportedCurrencyJSONService.load(
      fileName: config.supportedCurrenciesFileName
    ) else {
      return
    }

    self.supportedCurrencies = supportedCurrencies
  }

  ///
  ///  Load rules for exchanging currencies defined in a JSON file
  ///
  func loadCurrencyExchangeRules() {
    guard let currencyExchangeRules = currencyExchangeRuleJSONService.load(
      fileName: config.currencyExchangeRulesFileName
    ) else {
      return
    }

    self.currencyExchangeRules = currencyExchangeRules
  }

  ///
  /// Load initial wallets for User on first app open
  ///
  func saveInitialWallets() {
    if !UserDefaults.hasUsedInitialWallets {
      if let initialWallets = walletJSONService.load(fileName: App.shared.config.initialUserWalletsFileName) {
        for initialWallet in initialWallets {
          walletService.add(initialWallet)
        }

        UserDefaults.hasUsedInitialWallets = true
      }
    }
  }
}
