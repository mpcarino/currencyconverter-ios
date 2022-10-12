//
//  TransactionsViewModelProtcol.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation
import RxSwift
import RxRelay

protocol TransactionsViewModelProtocol {
  var contentState: PublishSubject<ContentState> { get }
  
  var transactions: [Transaction] { get }
  
  func load()
  
  func getTransactionTableCellVM(at indexPath: IndexPath) -> TransactionTableCellViewModelProtocol
}
