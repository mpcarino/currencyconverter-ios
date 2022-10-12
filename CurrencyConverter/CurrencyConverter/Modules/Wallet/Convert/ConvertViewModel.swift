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
  case success
  case error(Error)
}

class ConvertViewModel: ConvertViewModelProtocol {
  // MARK: - Properties
  
  private(set) var onConvert: CurrencyConversionClosure = { (_, _) in }
  
  let contentState = PublishSubject<ContentState>()
  let isValidSourceAmount = BehaviorRelay<Bool>(value: false)
  let sourceAmount = BehaviorRelay<Decimal>(value: .zero)
  let destinationAmount = BehaviorRelay<Decimal>(value: .zero)
  let conversionInfo = BehaviorRelay<String>(value: .empty)
  
  private(set) var user: User
  private(set) var sourceWallet: Wallet
  private(set) var destinationWallet: Wallet
  private(set) var supportedCurrencies: [Currency]
  private(set) var commissionRate: Double
 
  private var currencyExchangeService: CurrencyExchangeServiceProtocol

  // MARK: - Init

  init(
    user: User,
    sourceWallet: Wallet,
    destinationWallet: Wallet,
    supportedCurrencies: [Currency] = App.shared.supportedCurrencies,
    commissionRate: Double = App.shared.config.commissionRate,
    currencyExchangeService: CurrencyExchangeServiceProtocol = App.shared.currencyExchangeService,
    onConvert: @escaping CurrencyConversionClosure
  ) {
    self.user = user
    self.sourceWallet = sourceWallet
    self.destinationWallet = destinationWallet
    self.supportedCurrencies = supportedCurrencies.filter({ $0 != sourceWallet.currency })
    self.commissionRate = commissionRate
    self.currencyExchangeService = currencyExchangeService
    self.onConvert = onConvert
  }
}

// MARK: - Methods

extension ConvertViewModel {
  func convert() {
    let commissionFee = getCommissionFee()
    let totalSourceDeductible = sourceAmount.value + commissionFee
    
    guard totalSourceDeductible <= sourceWallet.balance else {
      isValidSourceAmount.accept(false)
      contentState.onNext(.error(CurrencyExchangeError.insufficientBalance))
      return
    }
    
    contentState.onNext(.loading)
    
    // Adding delay for the purpose of mimicking API call
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
      guard let self = self else { return }
      
      self.sourceWallet.subtract(amount: totalSourceDeductible)
      self.destinationWallet.add(amount: self.destinationAmount.value)
      
      self.contentState.onNext(.success)
      
      self.user.updateWallet(self.sourceWallet)
      self.user.updateWallet(self.destinationWallet)
      
      self.onConvert(self.sourceWallet, self.destinationWallet)
    }
  }
  
  func exchangeSourceToDestination(for amount: Decimal) {
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
        
        sourceAmount.accept(amount)
        destinationAmount.accept(Decimal(string: currencyExchange.amount) ?? .zero)
        
        updateConversionInfo()
        
        contentState.onNext(.ready)
      } catch {
        contentState.onNext(.error(APIError.invalidRequest))
      }
    }
  }

  func exchangeDestinationToSource(for amount: Decimal) {
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
        
        destinationAmount.accept(amount)
        sourceAmount.accept(Decimal(string: currencyExchange.amount) ?? .zero)
    
        updateConversionInfo()
        
        contentState.onNext(.ready)
      } catch {
        contentState.onNext(.error(APIError.invalidRequest))
      }
    }
  }
  
  func getCommissionFee() -> Decimal {
    return (sourceAmount.value * Decimal(commissionRate)) / 100.0
  }

  func changeDestinationWallet(to index: Int) {
    let selectedCurrency = getSupportedCurrency(at: index)
    var selectedWallet =  Wallet(
      balance: .zero,
      currency: selectedCurrency
    )
    
    if let wallet = user.wallets.first(where: {
      $0.currency == selectedCurrency
    }) {
      selectedWallet = wallet
    }

    destinationWallet = selectedWallet
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
      contentState.onNext(.error(CurrencyExchangeError.invalidAmount))
      return
    }
    
    guard sourceAmount.value <= sourceWallet.balance else {
      isValidSourceAmount.accept(false)
      contentState.onNext(.error(CurrencyExchangeError.insufficientBalance))
      return
    }

    isValidSourceAmount.accept(true)
  }

  func getSupportedCurrency(at index: Int) -> Currency {
    guard index < supportedCurrencies.count else {
      preconditionFailure("Index must be less than the size of supported currencies")
    }

    return supportedCurrencies[index]
  }
  
  func updateConversionInfo() {
    let commissionFee = getCommissionFee()
    let totalSourceDeductible = sourceAmount.value + commissionFee
    
    let info = S.convertConversionInfo(
      "\(commissionRate)%",
      sourceWallet.currency.currencyFormatter.string(amount: commissionFee as NSNumber),
      sourceWallet.currency.currencyFormatter.string(amount: totalSourceDeductible as NSNumber),
      destinationWallet.currency.currencyFormatter.string(amount: destinationAmount.value as NSNumber)
    )
    
    conversionInfo.accept(info)
  }
}
