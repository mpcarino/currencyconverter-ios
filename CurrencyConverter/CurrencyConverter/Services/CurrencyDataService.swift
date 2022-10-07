//
//  CurrencyDataService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation

class CurrencyDataService: JSONDataServiceProtocol {
    typealias T = [Currency]
    
    private let fileName = "SupportedCurrencies"
    
    func load() -> T? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }

        let url = URL(fileURLWithPath: path)

        if let data = try? Data(contentsOf: url),
           let decodedData = try? JSONDecoder().decode(T.self, from: data) {
            return decodedData
        }

        return nil
    }
}
