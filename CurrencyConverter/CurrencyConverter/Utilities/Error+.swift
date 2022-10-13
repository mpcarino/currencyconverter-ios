//
//  Error+.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

enum AppError: Error, LocalizedError {
  case unknown
  
  var errorDescription: String? {
    switch self {
    case .unknown:
      return S.errorAppUnknown()
    }
  }
}

enum APIError: Error, LocalizedError {
  case invalidURL
  case invalidRequest
  case dataNotFound
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return S.errorApiInvalidURL()
    case .invalidRequest:
      return S.errorApiInvalidRequest()
    case .dataNotFound:
      return S.errorApiDataNotFound()
    }
  }
}

enum CurrencyExchangeError: Error, LocalizedError {
  case invalidDestinationWallet
  case invalidAmount
  case insufficientBalance
  
  var errorDescription: String? {
    switch self {
    case .invalidDestinationWallet:
      return S.errorCurrencyExchangeInvalidDestinationWallet()
    case .invalidAmount:
      return S.errorCurrencyExchangeInvalidAmount()
    case .insufficientBalance:
      return S.errorCurrencyExchangeInsufficientBalance()
    }
  }
}
