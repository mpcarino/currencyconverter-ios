//
//  ConvertViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Marwin Carino on 10/12/22.
//

import XCTest

@testable import CurrencyConverter

final class ConvertViewModelTests: XCTestCase {
  private let mockWalletWithBalance = Wallet.init(balance: 1_000, currency: .init(locale: "a_A", code: "A"))
  private let mockWalletWithoutBalance = Wallet.init(balance: .zero, currency: .init(locale: "b_B", code: "B"))
  private let mockWalletC = Wallet.init(balance: .zero, currency: .init(locale: "c_C", code: "C"))
  private let mockWalletD = Wallet.init(balance: .zero, currency: .init(locale: "d_D", code: "D"))
  private let mockWalletE = Wallet.init(balance: .zero, currency: .init(locale: "e_E", code: "E"))
  
  
  private let mockCommissionRate = 0.7
  
  private var mockWallets: [Wallet] = []
  private var mockWalletVM: WalletViewModelProtocol = WalletViewModel()
  
  // MARK: - Setup
  
  override func setUpWithError() throws {
    mockWallets = [
      mockWalletWithBalance,
      mockWalletWithoutBalance,
      mockWalletC,
      mockWalletD,
      mockWalletE
    ]
    
    mockWalletVM = WalletViewModel()
  }

  // MARK: - Methods
  
  func test_commissionRate() {
    let sut: ConvertViewModelProtocol = ConvertViewModel(
      sourceWallet: mockWalletWithBalance,
      destinationWallet: mockWalletWithoutBalance,
      commissionRate: mockCommissionRate
    )
    
    XCTAssertEqual(mockCommissionRate, sut.commissionRate)
  }
  
  func test_getCommissionFee() {
    let sut: ConvertViewModelProtocol = ConvertViewModel(
      sourceWallet: mockWalletWithBalance,
      destinationWallet: mockWalletWithoutBalance,
      commissionRate: mockCommissionRate
    )
    
    sut.sourceAmount.accept(100)
    
    let commissionFee = sut.getCommissionFee()

    XCTAssertEqual(0.7, commissionFee)
  }
  
  func test_convert_zero_sourceAmount() {
    let sut: ConvertViewModelProtocol = ConvertViewModel(
      sourceWallet: mockWalletWithBalance,
      destinationWallet: mockWalletWithoutBalance,
      commissionRate: mockCommissionRate
    )
    
    sut.sourceAmount.accept(0)
    sut.destinationAmount.accept(0)
    
    sut.convert()
    
    XCTAssertEqual(0, sut.destinationWallet.balance)
  }
  
  func test_convert_negative_sourceAmount() {
    let sut: ConvertViewModelProtocol = ConvertViewModel(
      sourceWallet: mockWalletWithBalance,
      destinationWallet: mockWalletWithoutBalance,
      commissionRate: mockCommissionRate
    )
    
    sut.sourceAmount.accept(-100)
    sut.destinationAmount.accept(125)
    
    sut.convert()
    
    XCTAssertEqual(0, sut.destinationWallet.balance)
  }
  
  func test_convert_sourceAmount_equalBalance() {
    let sut: ConvertViewModelProtocol = ConvertViewModel(
      sourceWallet: mockWalletWithBalance,
      destinationWallet: mockWalletWithoutBalance,
      commissionRate: mockCommissionRate
    )
    
    sut.sourceAmount.accept(1_000)
    sut.destinationAmount.accept(1_025)
    
    sut.convert()
    
    XCTAssertEqual(0, sut.destinationWallet.balance)
  }
  
  func test_convert_sourceAmount_greaterThanBalance() {
    let sut: ConvertViewModelProtocol = ConvertViewModel(
      sourceWallet: mockWalletWithBalance,
      destinationWallet: mockWalletWithoutBalance,
      commissionRate: mockCommissionRate
    )
    
    sut.sourceAmount.accept(1_001)
    sut.destinationAmount.accept(1_025)
    
    sut.convert()
    
    XCTAssertEqual(0, sut.destinationWallet.balance)
  }
}
