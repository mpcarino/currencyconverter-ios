//
//  NumberFormatter.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation

extension NumberFormatter {
  func string(amount: NSNumber) -> String {
    return "\(string(from: amount) ?? .zero)"
  }

  func stringWithCode(amount: NSNumber) -> String {
    return "\(currencyCode ?? .empty) \(string(from: amount) ?? .zero)"
  }

  func stringWithSymbol(amount: NSNumber) -> String {
    return "\(currencySymbol ?? .empty) \(string(from: amount) ?? .zero)"
  }

  func stringWithCodeAndSymbol(amount: NSNumber) -> String {
    return "\(currencyCode ?? .empty) \(currencySymbol ?? .empty) \(string(from: amount) ?? .zero)"
  }
}
