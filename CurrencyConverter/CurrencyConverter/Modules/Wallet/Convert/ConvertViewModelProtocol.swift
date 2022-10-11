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
  var contentState: PublishSubject<ContentState> { get }
  var isValidSourceAmount: BehaviorRelay<Bool> { get }
  var sourceCurrencyExchange: PublishSubject<CurrencyExchangeResponse> { get }
  var destinationCurrencyExchange: PublishSubject<CurrencyExchangeResponse> { get }
  
  var sourceWallet: Wallet { get }
  var destinationWallet: Wallet { get }
  var supportedCurrencies: [Currency] { get }
  
  func getSourceCurrencyExchange(for amount: Decimal)
  
  func getDestinationCurrencyExchange(for amount: Decimal)
  
  func changeDestinationWallet(to index: Int)
  
  func getSupportedCurrencyText(at index: Int) -> String
}
