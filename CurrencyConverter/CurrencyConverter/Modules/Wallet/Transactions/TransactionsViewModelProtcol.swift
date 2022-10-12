//
//  TransactionsViewModelProtcol.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation

protocol TransactionsViewModelProtocol {
  var transactions: [Transaction] { get }
  
  func getTransactionTableCellVM(at indexPath: IndexPath) -> TransactionTableCellViewModelProtocol
}
