//
//  LocalDataService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/11/22.
//

import Foundation

protocol LocalDataServiceProtocol {
  associatedtype T
  
  var fileExtension: String { get }

  func load(fileName: String) -> T?
}
