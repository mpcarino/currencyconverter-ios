//
//  WalletController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

import RxSwift

class WalletController: UIViewController {
  // MARK: - Properties

  var viewModel: WalletViewModelProtocol!

  private var tableDataSource = WalletTableDataSource()
  private var tableDelegate = WalletTableDelegate()

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

// MARK: - Setup

private extension WalletController {
  func setup() {
    setupTableView()
    setupHandlers()
  }
  

  func setupTableView() {
    tableDataSource.wallets = viewModel.wallets

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

  func setupHandlers() {
    tableDelegate.onSelect = handleTableDelegateSelect()
  }
}

// MARK: - Binding

private extension WalletController {
  func bind() {
    bindNotifications()
  }
  
  func bindNotifications() {
    NotificationCenter.default.rx.notification(User.Notification.didUpdateWallets)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] _ in
        reloadTable()
      })
      .disposed(by: rx.disposeBag)
  }

}


// MARK: - Helpers

private extension WalletController {
  func reloadTable() {
    self.tableDataSource.wallets = viewModel.wallets
    self.tableView.reloadData()
  }
}

// MARK: - Handlers

private extension WalletController {
  func handleTableDelegateSelect() -> ((IndexPath) -> Void) {
    return { [weak self] indexPath in
      guard let self = self else { return }

      self.showConvert(for: indexPath.row)
    }
  }
}

// MARK: - Navigation

private extension WalletController {
  func showConvert(for index: Int) {
    let controller = R.storyboard.wallet.convertController()!
    controller.viewModel = viewModel.createConvertVM(for: index)

    show(controller, sender: self)
  }
}
