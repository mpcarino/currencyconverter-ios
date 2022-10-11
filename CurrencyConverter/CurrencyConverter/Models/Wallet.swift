//
//  Wallet.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

struct Wallet: Codable {
  static var `default`: Self {
    .init(
      balance: .zero,
      currency: Currency.default
    )
  }
  
  let balance: Decimal
  let currency: Currency
}

extension Wallet: Equatable {
  static func == (lhs: Wallet, rhs: Wallet) -> Bool {
    lhs.currency == rhs.currency
  }
}

// MARK: - Getters

extension Wallet {
  var formattedBalance: String {
    currency.currencyFormatter.string(amount: balance as NSNumber)
  }
}
