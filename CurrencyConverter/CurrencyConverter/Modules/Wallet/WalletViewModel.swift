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
    
    let convertVM = ConvertViewModel(
      sourceWallet: sourceWallet,
      onConvert: handleConvert()
    )
    
    return convertVM
  }
}

// MARK: - Handlers

private extension WalletViewModel {
  func handleConvert() -> CurrencyConversionClosure {
    return { [weak self] (sourceWallet, destinationWallet) in
      guard let self = self else { return }
      
      self.user.updateWallets(with: sourceWallet)
      self.user.updateWallets(with: destinationWallet)
    }
  }
}

// MARK: - Helpers

private extension WalletViewModel {
  
}

// MARK: - Getters

extension WalletViewModel {
  var defaultWallet: Wallet {
    App.shared.config.defaultWallet
  }
  
  var wallets: [Wallet] {
    user.wallets
  }
}
