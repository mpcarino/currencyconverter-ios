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
  
  func test_emptyWallets() {
    let sut = User(wallets: [])
    
    XCTAssertEqual(sut.wallets.count, 0)
  }
  
  func test_threeWallets() {
    let sut = User(wallets: mockWallets)
    
    XCTAssertEqual(sut.wallets.count, 3)
  }
}
