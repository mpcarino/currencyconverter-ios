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
  
  init(user: User) {
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
    
    return ConvertViewModel(sourceWallet: sourceWallet)
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
