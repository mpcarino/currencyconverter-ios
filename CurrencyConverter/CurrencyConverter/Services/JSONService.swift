//
//  JSONService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation

protocol JSONDataServiceProtocol {
    associatedtype T

    func load() -> T?
}
