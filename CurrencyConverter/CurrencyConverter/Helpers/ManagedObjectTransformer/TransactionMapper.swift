//
//  TransactionMapper.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/13/22.
//

import CoreData
import Foundation

class TransactionMapper: ManagedObjectMapFromProtocol, ManagedObjectMapToProtocol {
  // MARK: - Properties

  private let persistentContainer: NSPersistentContainer

  // MARK: - Init

  init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
  }
}

// MARK: - Methods

extension TransactionMapper {
  func map(_ item: NSManagedObject) -> Transaction {
    let transformedTransaction = Transaction(
      debitAmount: item.value(forKeyPath: "debitAmount") as! Decimal,
      debitCurrency: Currency(
        locale: item.value(forKeyPath: "debitLocale") as! String,
        code: item.value(forKeyPath: "debitCode") as! String
      ),
      creditAmount: item.value(forKeyPath: "creditAmount") as! Decimal,
      creditCurrency: Currency(
        locale: item.value(forKeyPath: "creditLocale") as! String,
        code: item.value(forKeyPath: "creditCode") as! String
      ),
      date: item.value(forKeyPath: "date") as! Date
    )

    return transformedTransaction
  }

  func map(_ item: Transaction) -> NSManagedObject {
    let transaction = CDTransaction(context: managedContext)

    transaction.setValue(item.debitAmount, forKeyPath: "debitAmount")
    transaction.setValue(item.debitCurrency.locale, forKeyPath: "debitLocale")
    transaction.setValue(item.debitCurrency.code, forKeyPath: "debitCode")
    transaction.setValue(item.creditAmount, forKeyPath: "creditAmount")
    transaction.setValue(item.creditCurrency.locale, forKeyPath: "creditLocale")
    transaction.setValue(item.creditCurrency.code, forKeyPath: "creditCode")
    transaction.setValue(item.date, forKeyPath: "date")

    return transaction
  }
}

// MARK: - Getters

extension TransactionMapper {
  var managedContext: NSManagedObjectContext {
    persistentContainer.viewContext
  }
}
