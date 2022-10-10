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
  case error(Error)
}

class ConvertViewModel: ConvertViewModelProtocol {
  
  // MARK: - Properties
  
  let contentState = PublishSubject<ContentState>()
  let isValidSourceAmount = BehaviorRelay<Bool>(value: false)
  let sourceCurrencyExchange = PublishSubject<CurrencyExchangeResponse>()
  let destinationCurrencyExchange = PublishSubject<CurrencyExchangeResponse>()
  
  private(set) var sourceWallet: Wallet
  private(set) var destinationWallet: Wallet
  private(set) var currencyExchangeService: CurrencyExchangeServiceProtocol
  
  private var sourceAmount: Decimal = .zero

  // MARK: - Init
  
  init(
    sourceWallet: Wallet,
    destinationWallet: Wallet = App.shared.config.defaultDestinationWallet,
    currencyExchangeService: CurrencyExchangeServiceProtocol = App.shared.currencyExchangeService
  ) {
    self.sourceWallet = sourceWallet
    self.destinationWallet = destinationWallet
    self.currencyExchangeService = currencyExchangeService
  }
}

// MARK: - Methods

extension ConvertViewModel {
  
  func getSourceCurrencyExchange(for amount: String) {
    Task.init {
      do {
        contentState.onNext(.loading)
        
        guard let currencyExchange = try await currencyExchangeService.convert(
          amount: amount,
          sourceCode: sourceWallet.currency.code,
          destinationCode: destinationWallet.currency.code
        ) else {
          contentState.onNext(.error(APIError.dataNotFound))
          return
        }
        
        updateSourceAmount(with: Decimal(string: amount))
        
        destinationCurrencyExchange.onNext(currencyExchange)
        contentState.onNext(.ready)
      } catch {
        contentState.onNext(.error(error))
      }
    }
  }
  
  func getDestinationCurrencyExchange(for amount: String) {
    Task.init {
      do {
        contentState.onNext(.loading)
        
        guard let currencyExchange = try await currencyExchangeService.convert(
          amount: amount,
          sourceCode: destinationWallet.currency.code,
          destinationCode: sourceWallet.currency.code
        ) else {
          contentState.onNext(.error(APIError.dataNotFound))
          return
        }
        
        updateSourceAmount(with: Decimal(string: currencyExchange.amount))
        
        sourceCurrencyExchange.onNext(currencyExchange)
        contentState.onNext(.ready)
      } catch {
        contentState.onNext(.error(error))
      }
    }
  }
}

// MARK: - Helpers

private extension ConvertViewModel {
  func updateSourceAmount(with amount: Decimal?) {
    sourceAmount = amount ?? .zero
    
    if sourceAmount > 0,
       sourceAmount < sourceWallet.balance {
      isValidSourceAmount.accept(true)
    } else {
      isValidSourceAmount.accept(false)
    }
  }
}
