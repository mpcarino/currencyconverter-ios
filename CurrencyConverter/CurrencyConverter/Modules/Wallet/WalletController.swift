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
    
    private lazy var currencyTableDataSource: CurrencyTableDataSource = {
        return CurrencyTableDataSource()
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
    }
    
    func setupTableView() {
        tableView.register(
            CurrencyTableCell.nib,
            forCellReuseIdentifier: CurrencyTableCell.reuseIdentifier
        )
        
        tableView.rowHeight = CurrencyTableCell.preferredHeight
        tableView.dataSource = currencyTableDataSource
        tableView.delegate = self
    }
}

extension WalletController: UITableViewDelegate {
    
}
