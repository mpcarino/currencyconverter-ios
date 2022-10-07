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
        setup()
    }
}

// MARK: - Setup

private extension CurrencyTableCell {
    func setup() {
        currencyLabel.text = nil
        balanceLabel.text = nil
    }
    
    func configureUI() {
        containerView.layer.cornerRadius = 8.0
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 0.25
        containerView.layer.shadowRadius = 2.5
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.10
        containerView.layer.shadowOffset = .init(width: 0.0, height: 2.5)
    }
}
