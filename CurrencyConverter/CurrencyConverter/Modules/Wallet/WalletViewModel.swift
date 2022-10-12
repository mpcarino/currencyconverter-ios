//
//  WalletViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation
import RxSwift
import RxRelay

class WalletViewModel: WalletViewModelProtocol {
  // MARK: - Properties
  
  let contentState = PublishSubject<ContentState>()
  
  private let session: Session
  private let walletService: JSONDataService<[Wallet]>
  
  // MARK: - Init
  
  init(
    session: Session = App.shared.session,
    walletService: JSONDataService<[Wallet]> = App.shared.walletService
  ) {
    self.session = session
    self.walletService = walletService
  }
}

// MARK: - Methods

extension WalletViewModel {
  func loadWallets() {
    contentState.onNext(.loading)
    
    if let initialWallets = walletService.load(fileName: App.shared.config.initialUserWalletsFileName) {
      session.user.setWallets(initialWallets)
    }
    
    contentState.onNext(.ready)
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
      destinationWallet: destinationWallet
    )
    
    return convertVM
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
      return Wallet.init(balance: .zero, currency: currency)
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
  
  var wallets: [Wallet] {
    session.user.wallets
  }
}
