//
//  WalletTests.swift
//  CurrencyConverterTests
//
//  Created by Marwin Carino on 10/12/22.
//

import XCTest

@testable import CurrencyConverter

final class WalletTests: XCTestCase {
  func test_add_balance() {
    var sut = Wallet(balance: 1_000, currency: .default)
    
    sut.add(amount: 500)
    
    XCTAssertEqual(1_500, sut.balance)
  }
  
  func test_subtract_balance() {
    var sut = Wallet(balance: 1_000, currency: .default)
    
    sut.subtract(amount: 500)
    
    XCTAssertEqual(500, sut.balance)
  }
}
