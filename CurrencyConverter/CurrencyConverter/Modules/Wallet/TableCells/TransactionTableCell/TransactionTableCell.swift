//
//  TransactionTableCell.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation
import UIKit

class TransactionTableCell: UITableViewCell {
  // MARK: - Properties

  static var preferredHeight: CGFloat { 74.0 }
  
  var viewModel: TransactionTableCellViewModelProtocol! {
    didSet {
      refresh()
    }
  }

  // MARK: - IBOutlets

  @IBOutlet private var containerView: UIView!
  @IBOutlet private var debitLabel: UILabel!
  @IBOutlet private var creditLabel: UILabel!
  @IBOutlet private var dateLabel: UILabel!
  
  // MARK: - Life Cycle

  override func awakeFromNib() {
    super.awakeFromNib()

    configureUI()
    setup()
  }
}

// MARK: - Methods

private extension TransactionTableCell {
  func configureUI() {
    containerView.layer.cornerRadius = 10.0
  }

  func setup() {
    debitLabel.text = nil
    creditLabel.text = nil
    dateLabel.text = nil
  }
  
  func refresh() {
    guard viewModel != nil else { return }
    
    debitLabel.text = viewModel.debitText
    creditLabel.text = viewModel.creditText
    dateLabel.text = viewModel.dateText
  }
}
