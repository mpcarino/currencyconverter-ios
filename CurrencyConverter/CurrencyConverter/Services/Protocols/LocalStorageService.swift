//
//  LocalStorageService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation

protocol LocalStorageAddServiceProtocol {
  associatedtype T

  func add(_ item: T)
}

protocol LocalStorageLoadServiceProtocol {
  associatedtype T

  func load() -> [T]?
}

protocol LocalStorageUpdateServiceProtocol {
  associatedtype T
  
  func update(_ item: T)
}

protocol LocalStorageDeleteServiceProtocol {
  associatedtype T
  
  func delete(_ item: T)
}
