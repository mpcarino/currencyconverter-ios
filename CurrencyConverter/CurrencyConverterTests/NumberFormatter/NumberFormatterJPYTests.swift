//
//  NumberFormatterJPYTests.swift
//  CurrencyConverterTests
//
//  Created by Marwin Carino on 10/11/22.
//

import XCTest

@testable import CurrencyConverter

final class NumberFormatterJPYTests: XCTestCase {
  private let jpyCurrency = Currency(locale: "ja_JP", code: "JPY")

  func testNumberToJPY() {
    let formatted = jpyCurrency.decimalFormatter.string(from: NSNumber(1000000))

    XCTAssertEqual(formatted, "1,000,000.00")
  }

  func testNumberWithThreeFractionDigitsRoundUpToJPY() {
    let formatted = jpyCurrency.decimalFormatter.string(from: NSNumber(1000000.555))

    XCTAssertEqual(formatted, "1,000,000.56")
  }

  func testNumberWithThreeFractionDigitsRoundDownToJPY() {
    let formatted = jpyCurrency.decimalFormatter.string(from: NSNumber(1000000.554))

    XCTAssertEqual(formatted, "1,000,000.55")
  }

  func testNumberToJPYWithCode() {
    let formatted = jpyCurrency.decimalFormatter.stringWithCode(amount: NSNumber(1000000))

    XCTAssertEqual(formatted, "JPY 1,000,000.00")
  }

  func testNumberToJPYWithSymbol() {
    let formatted = jpyCurrency.decimalFormatter.stringWithSymbol(amount: NSNumber(1000000))

    XCTAssertEqual(formatted, "¥ 1,000,000.00")
  }

  func testNumberToJPYWithCodeAndSymbol() {
    let formatted = jpyCurrency.decimalFormatter.stringWithCodeAndSymbol(amount: NSNumber(1000000))

    XCTAssertEqual(formatted, "JPY ¥ 1,000,000.00")
  }

  func testNumberToJPYUsingCurrencyFormatter() {
    let formatted = jpyCurrency.currencyFormatter.string(amount: NSNumber(1000000))

    XCTAssertEqual(formatted, "¥1,000,000.00")
  }
}
