//
//  UserTests.swift
//  CurrencyConverterTests
//
//  Created by Marwin Carino on 10/12/22.
//

import XCTest

@testable import CurrencyConverter

final class UserTests: XCTestCase {
  private let mockWallets = [
    Wallet.init(balance: .zero, currency: .init(locale: "A", code: "a_A")),
    Wallet.init(balance: .zero, currency: .init(locale: "B", code: "b_B")),
    Wallet.init(balance: .zero, currency: .init(locale: "C", code: "c_C"))
  ]
  
  private let mockTransactions = [
    Transaction(debitAmount: .zero, debitCurrency: Currency.default, creditAmount: .zero, creditCurrency: Currency.default, date: .now),
    Transaction(debitAmount: .zero, debitCurrency: Currency.default, creditAmount: .zero, creditCurrency: Currency.default, date: .now),
    Transaction(debitAmount: .zero, debitCurrency: Currency.default, creditAmount: .zero, creditCurrency: Currency.default, date: .now)
  ]
  
  func test_emptyWallets() {
    let sut = User(wallets: [], transactions: [])
    
    XCTAssertEqual(sut.wallets.count, 0)
  }
  
  func test_threeWallets() {
    let sut = User(wallets: mockWallets, transactions: [])
    
    XCTAssertEqual(sut.wallets.count, 3)
  }
  
  func test_emptyTransactions() {
    let sut = User(wallets: [], transactions: [])
    
    XCTAssertEqual(sut.transactions.count, 0)
  }
  
  func test_threeTransactions() {
    let sut = User(wallets: [], transactions: mockTransactions)
    
    XCTAssertEqual(sut.transactions.count, 3)
  }
}
