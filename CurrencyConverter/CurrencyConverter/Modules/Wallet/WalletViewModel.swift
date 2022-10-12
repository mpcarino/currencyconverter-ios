//
//  WalletViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

protocol WalletViewModelProtocol {
  var defaultWallet: Wallet { get }
  var wallets: [Wallet] { get }
  var transactionsVM: TransactionsViewModelProtocol { get }
  
  func getWallet(at index: Int) -> Wallet
  func createConvertVM(for index: Int) -> ConvertViewModelProtocol
}

class WalletViewModel: WalletViewModelProtocol {
  private let user: User
  
  init(user: User = App.shared.user) {
    self.user = user
  }
}

// MARK: - Methods

extension WalletViewModel {
  func getWallet(at index: Int) -> Wallet {
    guard index < wallets.count else {
      preconditionFailure("Index must be less than the size of wallets")
    }
    
    return wallets[index]
  }
  
  func createConvertVM(for index: Int) -> ConvertViewModelProtocol {
    let sourceWallet = getWallet(at: index)
    let destinationWallet = getPreferredDestinationWallet(for: sourceWallet)
    
    let convertVM = ConvertViewModel(
      user: user,
      sourceWallet: sourceWallet,
      destinationWallet: destinationWallet,
      onConvert: handleConvert()
    )
    
    return convertVM
  }
}

// MARK: - Handlers

private extension WalletViewModel {
  func handleConvert() -> CurrencyConversionClosure {
    return { [weak self] (_, _) in
      guard let self = self else { return }
      
      
    }
  }
}

// MARK: - Helpers

private extension WalletViewModel {
  func getPreferredDestinationWallet(for wallet: Wallet) -> Wallet {
    let preferredCurency = Currency.default
    
    if wallet.currency != preferredCurency {
      return createDestinationWallet(for: preferredCurency)
    } else {
      return createDestinationWallet(
        for: getPreferredCurrency(excluding: [preferredCurency]) ?? preferredCurency
      )
    }
  }
  
  func createDestinationWallet(for currency: Currency) -> Wallet {
    if let preferredWallet = wallets.first(where: { $0.currency == currency }) {
      return preferredWallet
    } else {
      return Wallet.init(balance: .zero, currency: currency)
    }
  }
  
  func getPreferredCurrency(excluding currencies: [Currency]) -> Currency? {
    let filteredCurrencies = App.shared.supportedCurrencies.filter({
      !currencies.contains($0)
    })
    
    return filteredCurrencies.first
  }
}

// MARK: - Getters

extension WalletViewModel {
  var defaultWallet: Wallet {
    App.shared.config.defaultWallet
  }
  
  var wallets: [Wallet] {
    user.wallets
  }
  
  var transactionsVM: TransactionsViewModelProtocol {
    TransactionsViewModel()
  }
}
