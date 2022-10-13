//
//  Session.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation

class Session {
  // MARK: - Properties
  
  private(set) var user: User
  
  // MARK: - Init
  
  init(user: User) {
    self.user = user
  }
}
