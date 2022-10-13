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
  @IBOutlet private var noCommissionView: UIView!
  
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
    noCommissionView.layer.cornerRadius = noCommissionView.frame.size.height / 2
  }

  func setup() {
    debitLabel.text = nil
    creditLabel.text = nil
    dateLabel.text = nil
    noCommissionView.isHidden = true
  }
  
  func refresh() {
    guard viewModel != nil else { return }
    
    debitLabel.text = viewModel.debitText
    creditLabel.text = viewModel.creditText
    dateLabel.text = viewModel.dateText
    noCommissionView.isHidden = viewModel.shouldHideNoCommissionTag
  }
}
