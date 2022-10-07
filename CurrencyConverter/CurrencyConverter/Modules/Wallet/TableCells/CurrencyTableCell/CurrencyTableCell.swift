//
//  CurrencyTableCell.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

import Reusable

class CurrencyTableCell: UITableViewCell, Reusable {
    // MARK: - Properties
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

// MARK: - Setup

private extension CurrencyTableCell {
    func setup() {
        
    }
}
