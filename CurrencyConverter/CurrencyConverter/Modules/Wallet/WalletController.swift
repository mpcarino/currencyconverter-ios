//
//  WalletController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

class WalletController: UIViewController {
  // MARK: - Properties

  var viewModel: WalletViewModelProtocol!

  private var tableDataSource = WalletTableDataSource(wallets: [])
  private var tableDelegate = WalletTableDelegate()

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel.loadData()
  }
}

// MARK: - Setup

private extension WalletController {
  func setup() {
    setupTableView()
    setupClosures()
  }

  func setupTableView() {
    tableDataSource = WalletTableDataSource(wallets: viewModel.wallets)
    
    tableView.register(
      WalletTableCell.nib,
      forCellReuseIdentifier: WalletTableCell.reuseIdentifier
    )

    tableView.dataSource = tableDataSource
    tableView.delegate = tableDelegate

    tableView.contentInset.top = 8.0
    tableView.contentInset.bottom = 8.0
    tableView.rowHeight = WalletTableCell.preferredHeight
  }

  func setupClosures() {
    tableDelegate.onSelect = handleTableDelegateSelect()
  }
}

// MARK: - Handlers

private extension WalletController {
  func handleTableDelegateSelect() -> ((IndexPath) -> Void) {
    return { [weak self] _ in
      guard let self = self else { return }

      self.showConvert()
    }
  }
}

// MARK: - Navigation

private extension WalletController {
  func showConvert() {
    let controller = R.storyboard.wallet.convertController()!
    show(controller, sender: self)
  }
}
