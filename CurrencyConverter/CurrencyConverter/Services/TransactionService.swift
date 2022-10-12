//
//  TransactionService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import CoreData
import Foundation

class TransactionService: LocalStorageServiceProtocol {
  typealias T = Transaction

  private let persistentContainer: NSPersistentContainer

  init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
  }

  func add(_ item: Transaction) {
    do {
      let entity = NSEntityDescription.entity(
        forEntityName: "CDTransaction",
        in: managedContext
      )!

      let cdTransaction = NSManagedObject(
        entity: entity,
        insertInto: managedContext
      )
      
      cdTransaction.setValue(item.debitAmount, forKeyPath: "debitAmount")
      cdTransaction.setValue(item.debitCurrency.locale, forKeyPath: "debitLocale")
      cdTransaction.setValue(item.debitCurrency.code, forKeyPath: "debitCode")
      
      cdTransaction.setValue(item.creditAmount, forKeyPath: "creditAmount")
      cdTransaction.setValue(item.creditCurrency.locale, forKeyPath: "creditLocale")
      cdTransaction.setValue(item.creditCurrency.code, forKeyPath: "creditCode")
      cdTransaction.setValue(item.date, forKeyPath: "date")
      
      let request = NSFetchRequest<NSManagedObject>(entityName: "CDTransaction")
      var cdTransactions = try managedContext.fetch(request)
      
      cdTransactions.append(cdTransaction)
      
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  func load() -> [Transaction]? {
    do {
      let request = NSFetchRequest<NSManagedObject>(entityName: "CDTransaction")
      let cdTransactions = try managedContext.fetch(request)

      let transactions = cdTransactions.map({
        Transaction(
          debitAmount: $0.value(forKeyPath: "debitAmount") as! Decimal,
          debitCurrency: Currency(
            locale: $0.value(forKeyPath: "debitLocale") as! String,
            code: $0.value(forKeyPath: "debitCode") as! String
          ),
          creditAmount: $0.value(forKeyPath: "creditAmount") as! Decimal,
          creditCurrency: Currency(
            locale: $0.value(forKeyPath: "creditLocale") as! String,
            code: $0.value(forKeyPath: "creditCode") as! String
          ),
          date: $0.value(forKeyPath: "date") as! Date
        )
      })

      return transactions
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")

      return nil
    }
  }

  func update(_ item: Transaction) {
  }

  func delete(_ item: Transaction) {
  }

  private func saveContext() {
    if managedContext.hasChanges {
      do {
        try managedContext.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  private var managedContext: NSManagedObjectContext {
    persistentContainer.viewContext
  }
}
