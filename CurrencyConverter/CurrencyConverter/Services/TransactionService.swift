//
//  TransactionService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import CoreData
import Foundation

class TransactionService:
  LocalStorageAddServiceProtocol,
  LocalStorageLoadServiceProtocol {
  // MARK: - Properties

  typealias T = Transaction

  private let persistentContainer: NSPersistentContainer
  private let transactionMapper: TransactionMapper

  // MARK: - Init

  init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
    transactionMapper = TransactionMapper(persistentContainer: persistentContainer)
  }
}

// MARK: - Methods

extension TransactionService {
  func add(_ item: Transaction) {
    do {
      let transaction = transactionMapper.map(item)
      var transactions = try managedContext.fetch(request)

      transactions.append(transaction)

      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  func load() -> [Transaction]? {
    do {
      let transactions = try managedContext.fetch(request)

      let mappedTransactions = transactions.map({
        transactionMapper.map($0)
      })

      return mappedTransactions
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")

      return nil
    }
  }
}

// MARK: - Getters

private extension TransactionService {
  var managedContext: NSManagedObjectContext {
    persistentContainer.viewContext
  }

  var entityName: String {
    "CDTransaction"
  }

  var request: NSFetchRequest<NSManagedObject> {
    NSFetchRequest<NSManagedObject>(entityName: entityName)
  }
}
