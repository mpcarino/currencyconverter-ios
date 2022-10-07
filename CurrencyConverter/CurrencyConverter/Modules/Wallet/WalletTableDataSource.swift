//
//  WalletTableDataSource.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

class WalletTableDataSource: NSObject, UITableViewDataSource {
  private(set) var wallets: [Wallet] = []
  
  private var tableCellVMs: [WalletTableCellViewModelProtocol] = []
  
  init(wallets: [Wallet]) {
    self.wallets = wallets
    
    self.tableCellVMs = wallets.map({
      WalletTableCellViewModel(wallet: $0)
    })
  }

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
