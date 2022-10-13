//
//  WalletController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

import NSObject_Rx
import RxCocoa
import RxRelay
import RxSwift

import SVProgressHUD

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

    viewModel.loadWallets()
  }

  // MARK: - IBActions

  @IBAction func didTapTransactionsButton(_ sender: Any) {
    showTransactions()
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
    bindModel()
    bindNotifications()
  }

  func bindModel() {
    viewModel.contentState
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] contentState in
        switch contentState {
        case .loading:
          SVProgressHUD.show()
        case .ready,
             .success:
          self.reloadTable()
          SVProgressHUD.dismiss()
        case let .error(error):
          SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
      })
      .disposed(by: rx.disposeBag)
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
    tableDataSource.wallets = viewModel.wallets
    tableView.reloadData()
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
    controller.viewModel = viewModel.getConvertVM(for: index)

    show(controller, sender: self)
  }

  func showTransactions() {
    let controller = R.storyboard.transactions.transactionsController()!
    controller.viewModel = viewModel.transactionsVM

    show(controller, sender: self)
  }
}
