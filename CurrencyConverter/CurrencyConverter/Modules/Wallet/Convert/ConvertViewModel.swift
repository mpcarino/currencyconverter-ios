//
//  ConvertViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation
import RxSwift
import RxRelay

enum ContentState {
  case loading
  case ready
  case error
}

protocol ConvertViewModelProtocol {
  var state: PublishSubject<ContentState> { get }
  var sourceCurrencyExchange: PublishSubject<CurrencyExchangeResponse> { get }
  var destinationCurrencyExchange: PublishSubject<CurrencyExchangeResponse> { get }
  var sourceWallet: Wallet { get }
  var destinationWallet: Wallet { get }
  
  func getSourceCurrencyExchange(for amount: String)
  
  func getDestinationCurrencyExchange(for amount: String)
}

class ConvertViewModel: ConvertViewModelProtocol {
  let state = PublishSubject<ContentState>()
  let sourceCurrencyExchange = PublishSubject<CurrencyExchangeResponse>()
  let destinationCurrencyExchange = PublishSubject<CurrencyExchangeResponse>()
  
  private(set) var sourceWallet: Wallet
  private(set) var destinationWallet: Wallet

  private let service = CurrencyExchangeService()

  init(
    sourceWallet: Wallet,
    destinationWallet: Wallet = App.shared.config.defaultDestinationWallet
  ) {
    self.sourceWallet = sourceWallet
    self.destinationWallet = destinationWallet
  }
}

// MARK: - Methods

extension ConvertViewModel {
  func getSourceCurrencyExchange(for amount: String) {
    Task.init {
      do {
        guard let currencyExchange = try await service.convert(
          amount: amount,
          sourceCode: sourceWallet.currency.code,
          destinationCode: destinationWallet.currency.code
        ) else {
          return
        }
        
        destinationCurrencyExchange.onNext(currencyExchange)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func getDestinationCurrencyExchange(for amount: String) {
    Task.init {
      do {
        guard let currencyExchange = try await service.convert(
          amount: amount,
          sourceCode: destinationWallet.currency.code,
          destinationCode: sourceWallet.currency.code
        ) else {
          return
        }
        
        sourceCurrencyExchange.onNext(currencyExchange)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

// MARK: - Helpers

private extension ConvertViewModel {
  
}
