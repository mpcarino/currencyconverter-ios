//
//  SupportedCurrencyService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

class SupportedCurrencyService: JSONDataServiceProtocol {
  typealias T = [Currency]

  func load() -> [Currency]? {
    let fileName = "SupportedCurrencies"

    guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
      return nil
    }

    let url = URL(fileURLWithPath: path)

    if let data = try? Data(contentsOf: url),
       let decodedData = try? JSONDecoder().decode(T.self, from: data) {
      return decodedData
    }

    return nil
  }
}
