//
//  NumberFormatterTests.swift
//  CurrencyConverterTests
//
//  Created by Marwin Carino on 10/7/22.
//

import XCTest

@testable import CurrencyConverter

final class CurrencyConverter: XCTestCase {
    
    func testNumberToEUR() {
        let eurCurrency = Currency(locale: "es_ES", code: "EUR")
        
        let formatted = eurCurrency.formatter.string(from: NSNumber(1_000_000))
        
        XCTAssertEqual(formatted, "1.000.000,00")
    }
    
    func testNumberWithThreeFractionDigitsRoundUpToEUR() {
        let eurCurrency = Currency(locale: "es_ES", code: "EUR")
        
        let formatted = eurCurrency.formatter.string(from: NSNumber(1_000_000.555))
        
        XCTAssertEqual(formatted, "1.000.000,56")
    }
    
    func testNumberWithThreeFractionDigitsRoundDownToEUR() {
        let eurCurrency = Currency(locale: "es_ES", code: "EUR")
        
        let formatted = eurCurrency.formatter.string(from: NSNumber(1_000_000.554))
        
        XCTAssertEqual(formatted, "1.000.000,55")
    }
    
    func testNumberToEURWithCode() {
        let eurCurrency = Currency(locale: "es_ES", code: "EUR")
        
        let formatted = eurCurrency.formatter.stringWithCode(amount: NSNumber(1_000_000))
        
        XCTAssertEqual(formatted, "EUR 1.000.000,00")
    }
    
    
    func testNumberToEURWithSymbol() {
        let eurCurrency = Currency(locale: "es_ES", code: "EUR")
        
        let formatted = eurCurrency.formatter.stringWithSymbol(amount: NSNumber(1_000_000))
        
        XCTAssertEqual(formatted, "€ 1.000.000,00")
    }
  
    func testNumberToEURWithCodeAndSymbol() {
        let eurCurrency = Currency(locale: "es_ES", code: "EUR")
        
        let formatted = eurCurrency.formatter.stringWithCodeAndSymbol(amount: NSNumber(1_000_000))
        
        XCTAssertEqual(formatted, "EUR € 1.000.000,00")
    }
 }