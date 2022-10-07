//
//  App.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

final class App {
    static let shared = App()

    // MARK: - Properties

    private(set) var currencyDataService: CurrencyDataService!

    private(set) var supportedCurrencies: [Currency]

    // MARK: - Init

    init() {
        supportedCurrencies = []
    }
}

// MARK: - Methods

extension App {
    func bootstrap(
        with application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        currencyDataService = CurrencyDataService()

        if let supportedCurrencies = currencyDataService.load() {
            self.supportedCurrencies = supportedCurrencies
        }
    }
}
