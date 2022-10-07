//
//  Wallet.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

struct Wallet: Codable {
  let balance: Decimal
  let currency: Currency
}

extension Wallet {
  var formattedBalance: String {
    currency.formatter.stringWithSymbol(amount: balance as NSNumber) ?? ""
  }
}
