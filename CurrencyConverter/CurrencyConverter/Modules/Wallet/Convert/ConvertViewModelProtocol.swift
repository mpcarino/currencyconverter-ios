//
//  ConvertViewModelProtocol.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/10/22.
//

import Foundation
import RxSwift
import RxRelay

protocol ConvertViewModelProtocol {
  var onConvert: CurrencyConversionClosure { get }
  
  var contentState: PublishSubject<ContentState> { get }
  var isValidSourceAmount: BehaviorRelay<Bool> { get }
  var sourceAmount: BehaviorRelay<Decimal> { get }
  var destinationAmount: BehaviorRelay<Decimal> { get }
  var conversionInfo: BehaviorRelay<String> { get }
  
  var sourceWallet: Wallet { get }
  var destinationWallet: Wallet { get }
  var supportedCurrencies: [Currency] { get }
  var commissionRate: Double { get }
  
  func convert()
  
  func exchangeSourceToDestination(for amount: Decimal)
  
  func exchangeDestinationToSource(for amount: Decimal)
  
  func getCommissionFee() -> Decimal
  
  func changeDestinationWallet(to index: Int)
  
  func getSupportedCurrencyText(at index: Int) -> String
}
