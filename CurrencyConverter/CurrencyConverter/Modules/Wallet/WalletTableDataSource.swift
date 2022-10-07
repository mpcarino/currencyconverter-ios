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
  
  init(wallets: [Wallet]) {
    self.wallets = wallets
  }

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return wallets.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: WalletTableCell.reuseIdentifier,
      for: indexPath
    ) as! WalletTableCell

    return cell
  }
}
