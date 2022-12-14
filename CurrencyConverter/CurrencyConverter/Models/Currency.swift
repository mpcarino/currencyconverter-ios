//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation

struct Currency: Codable {
  let locale: String
  let code: String
}

extension Currency {
  static var `default`: Self {
    .init(
      locale: "es_ES",
      code: "EUR"
    )
  }
}

extension Currency: Equatable {
  static func == (lhs: Currency, rhs: Currency) -> Bool {
    return lhs.locale == rhs.locale && lhs.code == rhs.code
  }
}

// MARK: - Getters

extension Currency {
  var currencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: locale)
    formatter.numberStyle = .currency
    formatter.minimumFractionDigits = App.shared.config.minimumFractionDigits
    formatter.maximumFractionDigits = App.shared.config.maximumFractionDigits

    return formatter
  }
  
  var decimalFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: locale)
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = App.shared.config.minimumFractionDigits
    formatter.maximumFractionDigits = App.shared.config.maximumFractionDigits

    return formatter
  }
}
