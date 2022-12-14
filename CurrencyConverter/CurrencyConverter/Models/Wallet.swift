//
//  Wallet.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

struct Wallet: Codable {
  var balance: Decimal
  let currency: Currency
}

extension Wallet {
  static var `default`: Self {
    .init(
      balance: .zero,
      currency: Currency.default
    )
  }
}

extension Wallet: Equatable {
  static func == (lhs: Wallet, rhs: Wallet) -> Bool {
    lhs.currency == rhs.currency
  }
}

// MARK: - Helpers

extension Wallet {
  mutating func subtract(amount: Decimal) {
    guard amount <= balance else { return }
    
    balance -= amount
  }
  
  mutating func add(amount: Decimal) {
    balance += amount
  }
}

// MARK: - Getters

extension Wallet {
  var formattedBalance: String {
    currency.currencyFormatter.string(amount: balance as NSNumber)
  }
}
