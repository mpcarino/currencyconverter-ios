//
//  User.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation

class User {
  struct Notification { }
  
  // MARK: - Properties
  
  private(set) var wallets: [Wallet]
  private(set) var transactions: [Transaction]
  
  // MARK: - Init
  
  init(
    wallets: [Wallet],
    transactions: [Transaction]
  ) {
    self.wallets = wallets
    self.transactions = transactions
  }
  
  // MARK: - Methods
  
  func setWallets(_ newWallets: [Wallet]) {
    wallets = newWallets
  }
  
  func addWallet(_ wallet: Wallet) {
    wallets.append(wallet)
  }
  
  func removeWallet(_ wallet: Wallet) {
    guard let index = wallets.firstIndex(where: {
      $0.currency == wallet.currency
    }) else { return }
    
    wallets.remove(at: index)
  }
  
  func updateWallet(_ wallet: Wallet) {
    guard let index = wallets.firstIndex(where: {
      $0.currency == wallet.currency
    }) else { return }
    
    wallets[index] = wallet
    
    NotificationCenter.default.post(name: Notification.didUpdateWallets, object: nil)
  }
  
  func setTransactions(_ newTransaction: [Transaction]) {
    transactions = newTransaction
  }
  
  func addTransaction(_ transaction: Transaction) {
    transactions.append(transaction)
  }
}

// MARK: - Notifications

extension User.Notification {
  static let didUpdateWallets = Notification.Name(rawValue: "notification.name.user.didUpdateWallets")
}
