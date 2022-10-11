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

  var onUpdateSourceAmount: ((Decimal) -> Void) = { _ in }
  var onUpdateDestinationAmount: ((Decimal) -> Void) = { _ in }
  
  private(set) var onConvert: CurrencyConversionClosure = { (_, _) in }
  
  let contentState = PublishSubject<ContentState>()
  
  let isValidSourceAmount = BehaviorRelay<Bool>(value: false)
  let conversionInfo = BehaviorRelay<String>(value: .empty)
  
  private(set) var sourceWallet: Wallet
  private(set) var destinationWallet: Wallet
  private(set) var supportedCurrencies: [Currency]
  private(set) var commissionRate: Double

  private var sourceAmount: Decimal = .zero
  private var destinationAmount: Decimal = .zero
 
  private var currencyExchangeService: CurrencyExchangeServiceProtocol

  // MARK: - Init

  init(
    sourceWallet: Wallet,
    destinationWallet: Wallet = App.shared.config.defaultDestinationWallet,
    supportedCurrencies: [Currency] = App.shared.supportedCurrencies,
    commissionRate: Double = App.shared.config.commissionRate,
    currencyExchangeService: CurrencyExchangeServiceProtocol = App.shared.currencyExchangeService,
    onConvert: @escaping CurrencyConversionClosure
  ) {
    self.sourceWallet = sourceWallet
    self.destinationWallet = destinationWallet
    self.supportedCurrencies = supportedCurrencies
    self.commissionRate = commissionRate
    self.currencyExchangeService = currencyExchangeService
    self.onConvert = onConvert
  }
}

// MARK: - Methods

extension ConvertViewModel {
  func convert() {
    guard sourceAmount < sourceWallet.balance else { return }
    
    let commissionFee = calculateCommissionFee()
    let totalSourceDeductible = sourceAmount + commissionFee
    
    guard totalSourceDeductible <= sourceWallet.balance else { return }
    
    contentState.onNext(.loading)
    
    // Adding delay for the purpose of mimicking API call
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
      guard let self = self else { return }
      
      self.sourceWallet.subtract(amount: totalSourceDeductible)
      self.destinationWallet.add(amount: self.destinationAmount)
      
      self.contentState.onNext(.success)
      
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

        sourceAmount = amount
        destinationAmount = Decimal(string: currencyExchange.amount) ?? .zero
        
        updateConversionInfo()
        
        contentState.onNext(.ready)
        
        onUpdateDestinationAmount(destinationAmount)
      } catch {
        contentState.onNext(.error(error))
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

        destinationAmount = amount
        sourceAmount = Decimal(string: currencyExchange.amount) ?? .zero
        
        updateConversionInfo()
   
        contentState.onNext(.ready)
        
        onUpdateSourceAmount(sourceAmount)
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
  
  func updateConversionInfo() {
    let commissionFee = calculateCommissionFee()
    let totalSourceDeductible = sourceAmount + commissionFee
    
    let info = S.convertConversionInfo(
      "\(commissionRate)%",
      sourceWallet.currency.currencyFormatter.string(amount: commissionFee as NSNumber),
      sourceWallet.currency.currencyFormatter.string(amount: totalSourceDeductible as NSNumber),
      destinationWallet.currency.currencyFormatter.string(amount: destinationAmount as NSNumber)
    )
    
    conversionInfo.accept(info)
  }
  
  func calculateCommissionFee() -> Decimal {
    return (sourceAmount * Decimal(commissionRate)) / 100.0
  }
}
