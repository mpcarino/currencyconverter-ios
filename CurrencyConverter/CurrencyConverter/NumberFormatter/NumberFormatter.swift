//
//  NumberFormatter.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation


extension NumberFormatter {
    func stringWithCode(amount: NSNumber) -> String? {
        return "\(currencyCode ?? "") \(string(from: amount) ?? "0")"
    }
    
    func stringWithSymbol(amount: NSNumber) -> String? {
        return "\(currencySymbol ?? "") \(string(from: amount) ?? "0")"
    }
    
    func stringWithCodeAndSymbol(amount: NSNumber) -> String? {
        return "\(currencyCode ?? "") \(currencySymbol ?? "") \(string(from: amount) ?? "0")"
    }
}
