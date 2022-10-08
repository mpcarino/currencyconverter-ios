//
//  CurrencyExchangeService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

protocol CurrencyExchangeServiceProtocol {
  associatedtype T
  
  func convert(
    amount: String,
    sourceCode: String,
    destinationCode: String
  ) async throws -> T?
}

class CurrencyExchangeService: CurrencyExchangeServiceProtocol {
  typealias T = CurrencyExchangeResponse
  
  private let session = URLSession.shared

  func convert(
    amount: String,
    sourceCode: String,
    destinationCode: String
  ) async throws -> CurrencyExchangeResponse? {
    let endpoint = S.endpointCurrencyExchange(
      amount,
      sourceCode.uppercased(),
      destinationCode.uppercased()
    )
    
    if let url = URL(string: endpoint) {
      let (data, _) = try await session.data(from: url)
      let decodedData = try JSONDecoder().decode(CurrencyExchangeResponse.self, from: data)
      
      return decodedData
    } else {
      return nil
    }
  }
}
