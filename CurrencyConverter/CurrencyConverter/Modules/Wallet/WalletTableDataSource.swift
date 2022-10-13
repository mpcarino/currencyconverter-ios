//
//  WalletTableDataSource.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

class WalletTableDataSource: NSObject, UITableViewDataSource {
  // MARK: - Properties

  var wallets: [Wallet] = [] {
    didSet {
      tableCellVMs = wallets.map({
        WalletTableCellViewModel(wallet: $0)
      })
    }
  }

  private var tableCellVMs: [WalletTableCellViewModelProtocol] = []

  // MARK: - Methods

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return tableCellVMs.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: WalletTableCell.reuseIdentifier,
      for: indexPath
    ) as! WalletTableCell

    cell.viewModel = tableCellVMs[indexPath.row]

    return cell
  }
}
