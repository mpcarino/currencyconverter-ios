//
//  ManagedObjectTransformerProtocol.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/13/22.
//

import CoreData
import Foundation

protocol ManagedObjectMapFromProtocol {
  associatedtype T
  
  var managedContext: NSManagedObjectContext { get }
  
  func map(_ item: NSManagedObject) -> T
}

protocol ManagedObjectMapToProtocol {
  associatedtype T
  
  var managedContext: NSManagedObjectContext { get }
  
  func map(_ item: T) -> NSManagedObject
}
