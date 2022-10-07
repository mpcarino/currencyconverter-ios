//
//  Wallet.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

struct Wallet: Codable {
  let amount: Decimal
  let currency: Currency
}
