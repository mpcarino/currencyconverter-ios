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
  
  private let session: Session
  private let transactionService: TransactionService
  
  // MARK: - Init

  init(
    session: Session = App.shared.session,
    transactionService: TransactionService = App.shared.transactionService
  ) {
    self.session = session
    self.transactionService = transactionService
  }
}

// MARK: - Methods

extension TransactionsViewModel {
  func load() {
    contentState.onNext(.loading)
    
    guard let transactions = transactionService.load() else {
      contentState.onNext(.error(APIError.dataNotFound))
      return
    }
    
    user.setTransactions(transactions)
    contentState.onNext(.ready)
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
  private var user: User {
    session.user
  }
  
  var transactions: [Transaction] {
    session.user.transactions
  }
}
