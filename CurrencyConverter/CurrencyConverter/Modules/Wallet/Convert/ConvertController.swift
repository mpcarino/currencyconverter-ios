//
//  ConvertController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

class ConvertController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var balanceContainerView: UIView!
    @IBOutlet weak var sourceContainerVIew: UIView!
    @IBOutlet weak var sourceAmountTextField: UITextField!
    @IBOutlet weak var destinationContainerView: UIView!
    @IBOutlet weak var destinationAmountTextField: UITextField!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Methods

private extension ConvertController {
    func configureUI() {
        balanceContainerView.layer.cornerRadius = 8.0
        sourceContainerVIew.layer.cornerRadius = 10.0
        destinationContainerView.layer.cornerRadius = 10.0
    }
    
    func setup() {
        
    }
}
