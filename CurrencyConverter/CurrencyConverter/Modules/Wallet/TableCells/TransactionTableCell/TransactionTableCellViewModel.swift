//
//  TransactionTableCellViewModel.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation
import CoreData

protocol TransactionTableCellViewModelProtocol {
  var debitText: String { get }
  var creditText: String { get }
  var dateText: String { get }
}

struct TransactionTableCellViewModel: TransactionTableCellViewModelProtocol {
  let transaction: Transaction
}

extension TransactionTableCellViewModel {
  var debitText: String {
    transaction.debitCurrency.currencyFormatter.string(amount: transaction.debitAmount as NSNumber)
  }
  
  var creditText: String {
    transaction.creditCurrency.currencyFormatter.string(amount: transaction.creditAmount as NSNumber)
  }
  
  var dateText: String {
    return App.shared.config.dateFormatter.string(from: transaction.date)
  }
}
