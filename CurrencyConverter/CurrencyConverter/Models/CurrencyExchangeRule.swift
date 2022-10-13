//
//  CurrencyExchangeRule.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/13/22.
//

import Foundation

struct CurrencyExchangeRule: Codable {
  enum `Type`: String, Codable {
    case source = "Source"
    case destination = "Destination"
  }
  
  let id: String
  let type: `Type`
  let code: String
  let transactionCount: Int
  let minimum: Decimal
}

extension CurrencyExchangeRule: Equatable {
  static func == (lhs: CurrencyExchangeRule, rhs: CurrencyExchangeRule) -> Bool {
    return lhs.id == rhs.id
  }
}
