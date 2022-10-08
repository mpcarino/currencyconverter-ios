//
//  JSONDataService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation

protocol JSONDataServiceProtocol {
  associatedtype T

  var fileExtension: String { get }

  func load() -> T?
}

extension JSONDataServiceProtocol {
  var fileExtension: String { "json" }
}
