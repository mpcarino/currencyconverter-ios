//
//  WalletViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import CoreData
import Foundation
import RxRelay
import RxSwift

class WalletViewModel: WalletViewModelProtocol {
  // MARK: - Properties

  let contentState = PublishSubject<ContentState>()

  private let session: Session
  private let walletService: WalletService

  // MARK: - Init

  init(
    session: Session = App.shared.session,
    walletService: WalletService = App.shared.walletService
  ) {
    self.session = session
    self.walletService = walletService
  }
}

// MARK: - Methods

extension WalletViewModel {
  func loadWallets() {
    contentState.onNext(.loading)

    guard let wallets = walletService.load() else {
      contentState.onNext(.error(APIError.dataNotFound))
      return
    }
    
    user.setWallets(wallets)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.contentState.onNext(.ready)
    }
  }

  func getWallet(at index: Int) -> Wallet {
    guard index < wallets.count else {
      preconditionFailure("Index must be less than the size of wallets")
    }

    return wallets[index]
  }

  func getConvertVM(for index: Int) -> ConvertViewModelProtocol {
    let sourceWallet = getWallet(at: index)
    let destinationWallet = getPreferredDestinationWallet(for: sourceWallet)

    let convertVM = ConvertViewModel(
      sourceWallet: sourceWallet,
      destinationWallet: destinationWallet,
      onCurrencyExchange: handleCurrencyExchange()
    )

    return convertVM
  }
}

// MARK: - Handlers

private extension WalletViewModel {
  func handleCurrencyExchange() -> CurrencyExchangeClosure {
    return { [weak self] sourceWallet, destinationWallet in
      guard let self = self else { return }

      self.user.updateWallet(sourceWallet)
      self.user.updateWallet(destinationWallet)
      
      self.walletService.update(sourceWallet)
      self.walletService.update(destinationWallet)
    }
  }
}

// MARK: - Helpers

private extension WalletViewModel {
  func getPreferredDestinationWallet(for wallet: Wallet) -> Wallet {
    let preferredCurency = Currency.default

    if wallet.currency != preferredCurency {
      return getDestinationWallet(for: preferredCurency)
    } else {
      return getDestinationWallet(
        for: getPreferredCurrency(excluding: [preferredCurency]) ?? preferredCurency
      )
    }
  }

  func getDestinationWallet(for currency: Currency) -> Wallet {
    if let preferredWallet = wallets.first(where: { $0.currency == currency }) {
      return preferredWallet
    } else {
      return Wallet(balance: .zero, currency: currency)
    }
  }

  func getPreferredCurrency(excluding currencies: [Currency]) -> Currency? {
    let filteredCurrencies = App.shared.supportedCurrencies.filter({
      !currencies.contains($0)
    })

    return filteredCurrencies.first
  }
}

// MARK: - Getters

extension WalletViewModel {
  var defaultWallet: Wallet {
    App.shared.config.defaultWallet
  }

  var transactionsVM: TransactionsViewModelProtocol {
    TransactionsViewModel()
  }
  
  private var user: User {
    session.user
  }

  var wallets: [Wallet] {
    session.user.wallets
  }
}
