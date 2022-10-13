//
//  WalletMapper.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/13/22.
//

import CoreData
import Foundation

class WalletMapper: ManagedObjectMapFromProtocol, ManagedObjectMapToProtocol {
  // MARK: - Properties

  private let persistentContainer: NSPersistentContainer

  // MARK: - Init

  init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
  }
}

// MARK: - Methods

extension WalletMapper {
  func map(_ item: NSManagedObject) -> Wallet {
    let transformedWallet = Wallet(
      balance: item.value(forKeyPath: "balance") as! Decimal,
      currency: Currency(
        locale: item.value(forKeyPath: "locale") as! String,
        code: item.value(forKeyPath: "code") as! String
      )
    )

    return transformedWallet
  }

  func map(_ item: Wallet) -> NSManagedObject {
    let wallet = CDWallet(context: managedContext)

    wallet.setValue(item.balance, forKeyPath: "balance")
    wallet.setValue(item.currency.locale, forKeyPath: "locale")
    wallet.setValue(item.currency.code, forKeyPath: "code")

    return wallet
  }
}

// MARK: - Getters

extension WalletMapper {
  var managedContext: NSManagedObjectContext {
    persistentContainer.viewContext
  }
}
