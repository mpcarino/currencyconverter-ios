//
//  WalletViewModelProtocol.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation
import RxSwift
import RxRelay

protocol WalletViewModelProtocol {
  var contentState: PublishSubject<ContentState> { get }
  
  var defaultWallet: Wallet { get }
  
  var wallets: [Wallet] { get }
  
  var transactionsVM: TransactionsViewModelProtocol { get }
  
  func loadWallets()
  
  func getWallet(at index: Int) -> Wallet
  
  func getConvertVM(for index: Int) -> ConvertViewModelProtocol
}
