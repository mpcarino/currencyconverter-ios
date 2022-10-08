//
//  WalletTableCellViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

protocol WalletTableCellViewModelProtocol {
  var balanceText: String { get }
  var currencyText: String { get }
}

struct WalletTableCellViewModel: WalletTableCellViewModelProtocol {
  let wallet: Wallet
}

extension WalletTableCellViewModel {
  var balanceText: String {
    wallet.formattedBalance
  }
  
  var currencyText: String {
    wallet.currency.formatter.currencyCode ?? .empty
  }
}
