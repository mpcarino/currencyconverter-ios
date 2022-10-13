//
//  WalletTableCell.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

class WalletTableCell: UITableViewCell {
  // MARK: - Properties
  
  static var preferredHeight: CGFloat { 74.0 }

  var viewModel: WalletTableCellViewModelProtocol! {
    didSet {
      refresh()
    }
  }

  // MARK: - IBOutlets

  @IBOutlet private var containerView: UIView!
  @IBOutlet private var balanceLabel: UILabel!
  @IBOutlet private var currencyLabel: UILabel!

  // MARK: - Life Cycle

  override func awakeFromNib() {
    super.awakeFromNib()

    configureUI()
    setup()
  }
}

// MARK: - Methods

private extension WalletTableCell {
  func configureUI() {
    containerView.layer.cornerRadius = 10.0
  }

  func setup() {
    balanceLabel.text = nil
    currencyLabel.text = nil
  }
  
  func refresh() {
    guard viewModel != nil else { return }
    
    currencyLabel.text = viewModel.currencyText
    balanceLabel.text = viewModel.balanceText
  }
}
