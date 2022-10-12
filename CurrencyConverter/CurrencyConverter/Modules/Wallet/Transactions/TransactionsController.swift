//
//  TransactionsController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation
import UIKit

class TransactionsController: UIViewController {
  // MARK: - Properties
  
  var viewModel: TransactionsViewModelProtocol!
  
  // MARK: - IBOutlets
  
  @IBOutlet private var tableView: UITableView!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
}

// MARK: - Setup

private extension TransactionsController {
  func setup() {
    setupTableView()
  }
  
  func setupTableView() {
    tableView.register(
      TransactionTableCell.nib,
      forCellReuseIdentifier: TransactionTableCell.reuseIdentifier
    )

    tableView.dataSource = self

    tableView.contentInset.top = 8.0
    tableView.contentInset.bottom = 8.0
    tableView.rowHeight = TransactionTableCell.preferredHeight
  }
}

// MARK: - UITableViewDataSource

extension TransactionsController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return viewModel.transactions.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: TransactionTableCell.reuseIdentifier,
      for: indexPath
    ) as! TransactionTableCell

    return cell
  }
}
