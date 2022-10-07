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
    
    private lazy var tableDataSource: CurrencyTableDataSource = {
        return CurrencyTableDataSource()
    }()
    
    private lazy var tableDelegate: CurrencyTableDelegate = {
        return CurrencyTableDelegate()
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Setup

private extension WalletController {
    func setup() {
        setupTableView()
        setupClosures()
    }
    
    func setupTableView() {
        tableView.register(
            CurrencyTableCell.nib,
            forCellReuseIdentifier: CurrencyTableCell.reuseIdentifier
        )
        
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
        
        tableView.contentInset.top = 8.0
        tableView.contentInset.bottom = 8.0
        tableView.rowHeight = CurrencyTableCell.preferredHeight
    }
    
    func setupClosures() {
        tableDelegate.onSelect = handleTableDelegateSelect()
    }
}

// MARK: - Handlers

private extension WalletController {
    func handleTableDelegateSelect() -> ((IndexPath) -> Void) {
        return { [weak self] indexPath in
            guard let self = self else { return }
            
            self.navigateToConvert()
        }
    }
}

// MARK: - Navigation

private extension WalletController {
    func navigateToConvert() {
        let controller = R.storyboard.wallet.convertController()!
        show(controller, sender: self)
    }
}
