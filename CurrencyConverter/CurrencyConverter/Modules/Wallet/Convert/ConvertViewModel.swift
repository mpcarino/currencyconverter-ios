//
//  ConvertViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation
import RxRelay
import RxSwift

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
  private(set) var supportedCurrencies: [Currency]
  private(set) var currencyExchangeService: CurrencyExchangeServiceProtocol

  private var sourceAmount: Decimal = .zero

  // MARK: - Init

  init(
    sourceWallet: Wallet,
    destinationWallet: Wallet = App.shared.config.defaultDestinationWallet,
    supportedCurrencies: [Currency] = App.shared.supportedCurrencies,
    currencyExchangeService: CurrencyExchangeServiceProtocol = App.shared.currencyExchangeService
  ) {
    self.sourceWallet = sourceWallet
    self.destinationWallet = destinationWallet
    self.supportedCurrencies = supportedCurrencies
    self.currencyExchangeService = currencyExchangeService
  }
}

// MARK: - Methods

extension ConvertViewModel {
  func getSourceCurrencyExchange(for amount: Decimal) {
    validate(amount: amount)

    guard isValidSourceAmount.value else { return }

    Task.init {
      do {
        contentState.onNext(.loading)

        guard let currencyExchange = try await currencyExchangeService.convert(
          amount: amount.description,
          sourceCode: sourceWallet.currency.code,
          destinationCode: destinationWallet.currency.code
        ) else {
          contentState.onNext(.error(APIError.dataNotFound))
          return
        }

        sourceAmount = amount

        destinationCurrencyExchange.onNext(currencyExchange)
        contentState.onNext(.ready)
      } catch {
        contentState.onNext(.error(error))
      }
    }
  }

  func getDestinationCurrencyExchange(for amount: Decimal) {
    validate(amount: amount)

    guard isValidSourceAmount.value else { return }

    Task.init {
      do {
        contentState.onNext(.loading)

        guard let currencyExchange = try await currencyExchangeService.convert(
          amount: amount.description,
          sourceCode: destinationWallet.currency.code,
          destinationCode: sourceWallet.currency.code
        ) else {
          contentState.onNext(.error(APIError.dataNotFound))
          return
        }

        sourceAmount = amount

        sourceCurrencyExchange.onNext(currencyExchange)
        contentState.onNext(.ready)
      } catch {
        contentState.onNext(.error(error))
      }
    }
  }

  func changeDestinationWallet(to index: Int) {
    let currency = getSupportedCurrency(at: index)

    destinationWallet = Wallet(balance: .zero, currency: currency)
  }

  func getSupportedCurrencyText(at index: Int) -> String {
    let currency = getSupportedCurrency(at: index)

    return "\(currency.code) - \(currency.currencyFormatter.currencySymbol ?? .empty)"
  }
}

// MARK: - Helpers

private extension ConvertViewModel {
  func validate(amount: Decimal) {
    guard amount > 0 else {
      isValidSourceAmount.accept(false)
      
      // TODO: Throw error
      return
    }

//    guard amount < sourceWallet.balance else {
//      isValidSourceAmount.accept(false)
//      return
//    }

    isValidSourceAmount.accept(true)
  }

  func getSupportedCurrency(at index: Int) -> Currency {
    guard index < supportedCurrencies.count else {
      preconditionFailure("Index must be less than the size of supported currencies")
    }

    return supportedCurrencies[index]
  }
}
