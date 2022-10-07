//
//  WalletViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation


protocol WalletViewModelProtocol {
  var supportedCurrencies: [Currency] { get }
  
  var wallets: [Wallet] { get }
  
  func loadData()
}

class WalletViewModel: WalletViewModelProtocol {
  private let user: User
  private let currencyDataService: CurrencyDataService
  
  private(set) var supportedCurrencies: [Currency]
  
  
  
  init(
    user: User = App.shared.user,
    currencyDataService: CurrencyDataService = App.shared.currencyDataService,
    supportedCurrencies: [Currency] = App.shared.supportedCurrencies
  ) {
    self.user = user
    self.currencyDataService = currencyDataService
    self.supportedCurrencies = supportedCurrencies
  }
}

// MARK: - Methods

extension WalletViewModel {
  func loadData() {
    loadSupportedCurrencies()
  }
  
  private func loadSupportedCurrencies() {
    guard let currencies = currencyDataService.load() else {
      return
    }
    
    self.supportedCurrencies = currencies
  }
}

// MARK: - Getters

extension WalletViewModel {
  var wallets: [Wallet] {
    user.wallets
  }
}
