//
//  CurrencyExchangeService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

protocol CurrencyExchangeServiceProtocol {
  func convert(
    amount: String,
    sourceCode: String,
    destinationCode: String
  ) async throws -> CurrencyExchange?
}

class CurrencyExchangeService: CurrencyExchangeServiceProtocol {
  // MARK: - Properties

  private let urlSession = URLSession.shared

  // MARK: - Methods

  func convert(
    amount: String,
    sourceCode: String,
    destinationCode: String
  ) async throws -> CurrencyExchange? {
    let endpoint = S.endpointCurrencyExchange(
      amount,
      sourceCode.uppercased(),
      destinationCode.uppercased()
    )

    if let url = URL(string: endpoint) {
      let (data, _) = try await urlSession.data(from: url)
      let decodedData = try JSONDecoder().decode(CurrencyExchange.self, from: data)

      return decodedData
    } else {
      return nil
    }
  }
}
