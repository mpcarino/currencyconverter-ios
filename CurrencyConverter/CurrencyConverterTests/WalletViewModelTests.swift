//
//  WalletViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Marwin Carino on 10/12/22.
//

import XCTest

@testable import CurrencyConverter

final class WalletViewModelTests: XCTestCase {
  private let mockWalletA = Wallet.init(balance: .zero, currency: .init(locale: "a_A", code: "A"))
  private let mockWalletB = Wallet.init(balance: .zero, currency: .init(locale: "b_B", code: "B"))
  private let mockWalletC = Wallet.init(balance: .zero, currency: .init(locale: "c_C", code: "C"))
  
  private var mockWallets: [Wallet] = []
  private var mockUser: User = User(wallets: [], transactions: [])
  private var mockSession: Session = Session(user: User(wallets: [], transactions: []))
  
  // MARK: - Setup
  
  override func setUpWithError() throws {
    mockWallets = [
      mockWalletA,
      mockWalletB,
      mockWalletC
    ]
    
    mockUser = User(wallets: mockWallets, transactions: [])
    mockSession = Session(user: mockUser)
  }

  // MARK: - Methods
  
  func test_emptyWallets() {
    let mockEmptySession = Session(user: User(wallets: [], transactions: []))
    
    let sut: WalletViewModelProtocol = WalletViewModel(session: mockEmptySession)

    XCTAssertEqual(sut.wallets.count, 0)
  }
  
  func test_threeWallets() {
    let sut: WalletViewModelProtocol = WalletViewModel(session: mockSession)

    XCTAssertEqual(sut.wallets.count, 3)
  }
  
  func test_getWallet() {
    let sut: WalletViewModelProtocol = WalletViewModel(session: mockSession)
    
    XCTAssertEqual(mockWalletA, sut.getWallet(at: 0))
  }
  
  func test_createConvertVM_sourceWallet() {
    let sut: WalletViewModelProtocol = WalletViewModel(session: mockSession)
    
    let convertVM = sut.getConvertVM(for: 0)
  
    XCTAssertEqual(mockWalletA, convertVM.sourceWallet)
  }
  
  func test_createConvertVM_defaultDestinationWallet() {
    let defaultDestinationWallet = AppConfig().defaultDestinationWallet
    let sut: WalletViewModelProtocol = WalletViewModel(session: mockSession)
    
    let convertVM = sut.getConvertVM(for: 0)
    
    XCTAssertEqual(defaultDestinationWallet, convertVM.destinationWallet)
  }
}
