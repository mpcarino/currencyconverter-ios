//
//  LocalStorageService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation

protocol LocalStorageServiceProtocol {
  associatedtype T

  func add(_ item: T)

  func load() -> [T]?

  func update(_ item: T)

  func delete(_ item: T)
}
