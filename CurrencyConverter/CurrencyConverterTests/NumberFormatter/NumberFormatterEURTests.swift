//
//  NumberFormatterEURTests.swift
//  CurrencyConverterTests
//
//  Created by Marwin Carino on 10/11/22.
//

import XCTest

@testable import CurrencyConverter

final class NumberFormatterEURTests: XCTestCase {
  private let eurCurrency = Currency(locale: "es_ES", code: "EUR")

  func testNumberToEUR() {
    let formatted = eurCurrency.decimalFormatter.string(from: NSNumber(1_000_000))

    XCTAssertEqual(formatted, "1.000.000,00")
  }

  func testNumberWithThreeFractionDigitsRoundUpToEUR() {
    let formatted = eurCurrency.decimalFormatter.string(from: NSNumber(1_000_000.555))

    XCTAssertEqual(formatted, "1.000.000,56")
  }

  func testNumberWithThreeFractionDigitsRoundDownToEUR() {
    let formatted = eurCurrency.decimalFormatter.string(from: NSNumber(1_000_000.554))

    XCTAssertEqual(formatted, "1.000.000,55")
  }

  func testNumberToEURWithCode() {
    let formatted = eurCurrency.decimalFormatter.stringWithCode(amount: NSNumber(1_000_000))

    XCTAssertEqual(formatted, "EUR 1.000.000,00")
  }

  func testNumberToEURWithSymbol() {
    let formatted = eurCurrency.decimalFormatter.stringWithSymbol(amount: NSNumber(1_000_000))

    XCTAssertEqual(formatted, "€ 1.000.000,00")
  }

  func testNumberToEURWithCodeAndSymbol() {
    let formatted = eurCurrency.decimalFormatter.stringWithCodeAndSymbol(amount: NSNumber(1_000_000))

    XCTAssertEqual(formatted, "EUR € 1.000.000,00")
  }

  func testNumberToEURUsingCurrencyFormatter() {
    let formatted = eurCurrency.currencyFormatter.string(amount: NSNumber(1_000_000))

    XCTAssertEqual(formatted, "1.000.000,00 €")
  }
}
