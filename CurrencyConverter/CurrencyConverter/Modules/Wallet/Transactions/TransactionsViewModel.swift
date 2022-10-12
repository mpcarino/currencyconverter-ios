//
//  TransactionsViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation

class TransactionsViewModel: TransactionsViewModelProtocol {
  // MARK: - Properties
  
  // MARK: - Init
  
  init() { }
}

// MARK: - Methods

extension TransactionsViewModel {
  func getTransactionTableCellVM(at indexPath: IndexPath) -> TransactionTableCellViewModelProtocol {
    return TransactionTableCellViewModel(transaction: getTransaction(at: indexPath.row))
  }
}

// MARK: - Helpers

private extension TransactionsViewModel {
  func getTransaction(at index: Int) -> Transaction {
    guard index < transactions.count else {
      preconditionFailure("Index must be less than the size of transactions")
    }
    
    return transactions[index]
  }
}

// MARK: - Getters

extension TransactionsViewModel {
  var transactions: [Transaction] {
    App.shared.user.transactions
  }
}
