//
//  CurrencyTableCell.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

class CurrencyTableCell: UITableViewCell {
    // MARK: - Properties
    
    static var preferredHeight: CGFloat { 74.0 }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
//        setup()
    }
}

// MARK: - Methods

private extension CurrencyTableCell {
    func configureUI() {
        containerView.layer.cornerRadius = 10.0
    }
    
    func setup() {
        currencyLabel.text = nil
        balanceLabel.text = nil
    }
}
