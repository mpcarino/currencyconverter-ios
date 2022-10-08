//
//  Error+.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

enum AppError: Error {
  case unknown
}

enum APIError: Error {
  case invalidURL
  case invalidRequest
  case dataNotFound
}

enum CurrencyExchangeError: Error {
  case invalidDestinationWallet
  case invalidAmount
  case insufficientBalance
}
