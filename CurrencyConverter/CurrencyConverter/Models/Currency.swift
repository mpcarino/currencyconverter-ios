//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation

struct Currency: Codable {
  static var `default`: Self {
    Currency(locale: "es_ES", code: "EUR")
  }

  let locale: String
  let code: String
}

extension Currency {
  var formatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: locale)
    formatter.currencyCode = code
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = App.shared.config.minimumFractionDigits
    formatter.maximumFractionDigits = App.shared.config.maximumFractionDigits

    return formatter
  }
}
