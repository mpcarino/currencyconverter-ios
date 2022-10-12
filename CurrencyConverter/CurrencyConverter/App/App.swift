
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
  
  private(set) var config: AppConfigProtocol!
  private(set) var session: Session!

  private(set) var supportedCurrencyService: JSONDataService<[Currency]>!
  private(set) var walletService: JSONDataService<[Wallet]>!
  
  private(set) var currencyExchangeService: CurrencyExchangeServiceProtocol!
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
    config = AppConfig()
    
    supportedCurrencyService = JSONDataService<[Currency]>(decoder: config.jsonDecoder)
    walletService = JSONDataService<[Wallet]>(decoder: config.jsonDecoder)
    
    currencyExchangeService = CurrencyExchangeService()
    transactionService = TransactionService(persistentContainer: persistentContainer)
    
    session = Session(user: User(wallets: [], transactions: []))
    
    loadSupportedCurrencies()
  }
}

// MARK: - Helpers

private extension App {
  func loadSupportedCurrencies() {
    guard let supportedCurrencies = supportedCurrencyService.load(fileName: config.supportedCurrenciesFileName) else {
      return
    }

    self.supportedCurrencies = supportedCurrencies
  }
}
