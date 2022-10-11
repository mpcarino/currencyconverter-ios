//
//  NumberFormatterUSDTests.swift
//  CurrencyConverterTests
//
//  Created by Marwin Carino on 10/11/22.
//

import XCTest

@testable import CurrencyConverter

final class NumberFormatterUSDTests: XCTestCase {
  private let usdCurrency = Currency(locale: "en_US", code: "USD")

  func testNumberToUSD() {
    let formatted = usdCurrency.decimalFormatter.string(from: NSNumber(1000000))

    XCTAssertEqual(formatted, "1,000,000.00")
  }

  func testNumberWithThreeFractionDigitsRoundUpToUSD() {
    let formatted = usdCurrency.decimalFormatter.string(from: NSNumber(1000000.555))

    XCTAssertEqual(formatted, "1,000,000.56")
  }

  func testNumberWithThreeFractionDigitsRoundDownToUSD() {
    let formatted = usdCurrency.decimalFormatter.string(from: NSNumber(1000000.554))

    XCTAssertEqual(formatted, "1,000,000.55")
  }

  func testNumberToUSDWithCode() {
    let formatted = usdCurrency.decimalFormatter.stringWithCode(amount: NSNumber(1000000))

    XCTAssertEqual(formatted, "USD 1,000,000.00")
  }

  func testNumberToUSDWithSymbol() {
    let formatted = usdCurrency.decimalFormatter.stringWithSymbol(amount: NSNumber(1000000))

    XCTAssertEqual(formatted, "$ 1,000,000.00")
  }

  func testNumberToUSDWithCodeAndSymbol() {
    let formatted = usdCurrency.decimalFormatter.stringWithCodeAndSymbol(amount: NSNumber(1000000))

    XCTAssertEqual(formatted, "USD $ 1,000,000.00")
  }

  func testNumberToUSDUsingCurrencyFormatter() {
    let formatted = usdCurrency.currencyFormatter.string(amount: NSNumber(1000000))

    XCTAssertEqual(formatted, "$1,000,000.00")
  }
}
