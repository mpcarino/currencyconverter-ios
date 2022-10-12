//
//  TransactionsViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation
import RxRelay
import RxSwift

class TransactionsViewModel: TransactionsViewModelProtocol {
  
  // MARK: - Properties
  
  let contentState = PublishSubject<ContentState>()
  
  private let transactionService: TransactionService
  
  private(set) var transactions: [Transaction] = []
  
  // MARK: - Init

  init(transactionService: TransactionService = App.shared.transactionService) {
    self.transactionService = transactionService
  }
}

// MARK: - Methods

extension TransactionsViewModel {
  func load() {
    transactions = transactionService.load() ?? []
  }
  
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
  
}
