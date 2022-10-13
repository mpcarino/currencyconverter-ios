//
//  CurrencyExchangeRuleService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/13/22.
//

import CoreData
import Foundation

protocol CurrencyExchangeRuleServiceProtocol {
  func getApplicableRule(
    for user: User,
    sourceAmount: Decimal,
    sourceCode: String,
    destinationAmount: Decimal,
    destinationCode: String
  ) -> CurrencyExchangeRule?

  func apply(_ rule: CurrencyExchangeRule)
}

class CurrencyExchangeRuleService: CurrencyExchangeRuleServiceProtocol {
  // MARK: - Properties

  private let rules: [CurrencyExchangeRule]
  private let persistentContainer: NSPersistentContainer

  // MARK: - Init

  init(
    rules: [CurrencyExchangeRule] = App.shared.currencyExchangeRules,
    persistentContainer: NSPersistentContainer
  ) {
    self.rules = rules
    self.persistentContainer = persistentContainer
  }

  // MARK: - Methods

  func getApplicableRule(
    for user: User,
    sourceAmount: Decimal,
    sourceCode: String,
    destinationAmount: Decimal,
    destinationCode: String
  ) -> CurrencyExchangeRule? {
    let appliedCurrencyExchangeRules = load() ?? []

    let userTransactionCount = user.transactions.count + 1

    for rule in rules {
      guard !appliedCurrencyExchangeRules.contains(rule.id) else { continue }

      switch rule.type {
      case .source:
        if sourceAmount >= rule.minimum,
           sourceCode == rule.code,
           userTransactionCount >= rule.transactionCount {
          return rule
        }
      case .destination:
        if destinationAmount >= rule.minimum,
           destinationCode == rule.code,
           userTransactionCount >= rule.transactionCount {
          return rule
        }
      }
    }

    return nil
  }

  func apply(_ rule: CurrencyExchangeRule) {
    add(rule.id)
  }
}

// MARK: - Helpers

private extension CurrencyExchangeRuleService {
  func add(_ item: String) {
    do {
      let currencyExchangeRule = CDCurrencyExchangeRule(context: managedContext)
      currencyExchangeRule.setValue(item, forKeyPath: "id")

      var currencyExchangeRules = try managedContext.fetch(request)
      currencyExchangeRules.append(currencyExchangeRule)

      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  func load() -> [String]? {
    do {
      let usedCurrencyExchangeRules = try managedContext.fetch(request)

      let mapUsedCurrencyExchangeRules = usedCurrencyExchangeRules.map({
        $0.value(forKeyPath: "id") as! String
      })

      return mapUsedCurrencyExchangeRules
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")

      return nil
    }
  }
}

// MARK: - Getters

private extension CurrencyExchangeRuleService {
  var managedContext: NSManagedObjectContext {
    persistentContainer.viewContext
  }

  var entityName: String {
    "CDCurrencyExchangeRule"
  }

  var request: NSFetchRequest<NSManagedObject> {
    NSFetchRequest<NSManagedObject>(entityName: entityName)
  }
}
