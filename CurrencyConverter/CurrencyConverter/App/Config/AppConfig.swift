//
//  AppConfig.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

protocol AppConfigProtocol {
  var defaultWallet: Wallet { get }
  var defaultDestinationWallet: Wallet { get }
  
  var minimumFractionDigits: Int { get }
  var maximumFractionDigits: Int { get }
  
  var commissionRate: Double { get }
  
  var supportedCurrenciesFileName: String { get }
  var initialUserWalletsFileName: String { get }
  
  var jsonDecoder: JSONDecoder { get }
}

extension AppConfigProtocol {
  var defaultWallet: Wallet { .default }
  var defaultDestinationWallet: Wallet { .default }
  
  var minimumFractionDigits: Int { 2 }
  var maximumFractionDigits: Int { 2 }
  
  var commissionRate: Double { 0.7 }
  
  var supportedCurrenciesFileName: String { Constant.JSON.supportedCurrencies }
  var initialUserWalletsFileName: String { Constant.JSON.initialUserWallets }
  
  var jsonDecoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return decoder
  }
}

class AppConfig: AppConfigProtocol { }
