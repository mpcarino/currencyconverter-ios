//
//  WalletService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/13/22.
//

import CoreData
import Foundation

class WalletService:
  LocalStorageAddServiceProtocol,
  LocalStorageLoadServiceProtocol,
  LocalStorageUpdateServiceProtocol {
  // MARK: - Properties

  typealias T = Wallet

  private var wallets: [NSManagedObject] = []

  private let persistentContainer: NSPersistentContainer
  private let walletMapper: WalletMapper

  // MARK: - Init

  init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
    walletMapper = WalletMapper(persistentContainer: persistentContainer)
  }
}

// MARK: - Methods

extension WalletService {
  func add(_ item: Wallet) {
    do {
      let wallet = walletMapper.map(item)
      var wallets = try managedContext.fetch(request)

      wallets.append(wallet)

      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  func load() -> [Wallet]? {
    do {
      wallets = try managedContext.fetch(request)

      let mappedWalelts = wallets.map({
        walletMapper.map($0)
      })

      return mappedWalelts
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")

      return nil
    }
  }

  func update(_ item: Wallet) {
    do {
      guard let wallet = getWallet(for: item) else {
        return
      }

      wallet.setValue(item.balance, forKeyPath: "balance")

      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
}

// MARK: - Helpers

private extension WalletService {
  func getWallet(for wallet: Wallet) -> NSManagedObject? {
    guard let cdWallet = wallets.first(where: {
      $0.value(forKeyPath: "locale") as! String == wallet.currency.locale &&
        $0.value(forKeyPath: "code") as! String == wallet.currency.code
    }) else {
      return nil
    }

    return cdWallet
  }
}

// MARK: - Getters

private extension WalletService {
  var managedContext: NSManagedObjectContext {
    persistentContainer.viewContext
  }

  var entityName: String {
    "CDWallet"
  }
  
  var request: NSFetchRequest<NSManagedObject> {
    NSFetchRequest<NSManagedObject>(entityName: entityName)
  }
}
