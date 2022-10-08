//
//  ConvertViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation
import RxRelay

protocol ConvertViewModelProtocol {
  var sourceWallet: Wallet { get }
  var destinationWallet: Wallet { get }
  
  func getCurrencyExchange(for amount: String, source: Wallet, destination: Wallet)
}

class ConvertViewModel: ConvertViewModelProtocol {
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
  func getCurrencyExchange(for amount: String, source: Wallet, destination: Wallet) {
    Task.init {
      do {
        let modelResponse = try await service.convert(
          amount: amount,
          sourceCode: source.currency.code,
          destinationCode: destination.currency.code
        )
        
        print(modelResponse)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

// MARK: - Helpers

private extension ConvertViewModel {
  
}
