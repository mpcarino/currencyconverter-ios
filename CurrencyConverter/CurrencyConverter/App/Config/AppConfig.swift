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
}

extension AppConfigProtocol {
  var defaultWallet: Wallet { .default }
  var defaultDestinationWallet: Wallet { .default }
  
  var minimumFractionDigits: Int { 2 }
  var maximumFractionDigits: Int { 2 }
}

class AppConfig: AppConfigProtocol { }
