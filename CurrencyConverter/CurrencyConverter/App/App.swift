
//
//  App.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit
import CoreData

import IQKeyboardManagerSwift

final class App {
  static let shared = App()

  // MARK: - Properties

  private(set) var supportedCurrencies: [Currency]
  
  private(set) var config: ConfigurationProtocol!
  private(set) var session: Session!

  private(set) var supportedCurrencyJSONService: JSONDataService<[Currency]>!
  private(set) var walletJSONService: JSONDataService<[Wallet]>!
  
  private(set) var currencyExchangeService: CurrencyExchangeServiceProtocol!
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
    
    currencyExchangeService = CurrencyExchangeService()
    walletService = WalletService(persistentContainer: persistentContainer)
    transactionService = TransactionService(persistentContainer: persistentContainer)
    
    session = Session(user: User(wallets: [], transactions: []))
    
    loadSupportedCurrencies()
    postInitialWallets()
  }
}

// MARK: - Helpers

private extension App {
  func loadSupportedCurrencies() {
    guard let supportedCurrencies = supportedCurrencyJSONService.load(fileName: config.supportedCurrenciesFileName) else {
      return
    }

    self.supportedCurrencies = supportedCurrencies
  }
  
  func postInitialWallets() {
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
