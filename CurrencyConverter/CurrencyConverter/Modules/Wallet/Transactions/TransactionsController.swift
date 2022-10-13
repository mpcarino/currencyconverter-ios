//
//  TransactionsController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import Foundation
import UIKit

import NSObject_Rx
import RxCocoa
import RxRelay
import RxSwift

import SVProgressHUD

class TransactionsController: UIViewController {
  // MARK: - Properties

  var viewModel: TransactionsViewModelProtocol!

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()

    viewModel.load()
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

// MARK: - Binding

private extension TransactionsController {
  func bind() {
    bindModel()
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
          self.tableView.reloadData()
          SVProgressHUD.dismiss()
        case let .error(error):
          SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
      })
      .disposed(by: rx.disposeBag)
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

    cell.viewModel = viewModel.getTransactionTableCellVM(at: indexPath)

    return cell
  }
}
