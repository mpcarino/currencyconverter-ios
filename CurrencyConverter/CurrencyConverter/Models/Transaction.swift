//
//  Transaction.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation

struct Transaction: Codable {
  let debitAmount: Decimal
  let debitCurrency: Currency
  
  let creditAmount: Decimal
  let creditCurrency: Currency
}
