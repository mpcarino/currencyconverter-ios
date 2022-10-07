//
//  ConvertController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

class ConvertController: UIViewController {
    @IBOutlet weak var balanceContainerView: UIView!
    @IBOutlet weak var feeContainerView: UIView!
    
    @IBOutlet weak var sourceContainerVIew: UIView!
    @IBOutlet weak var destinationContainerView: UIView!
    
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
        sourceContainerVIew.layer.cornerRadius = 8.0
        destinationContainerView.layer.cornerRadius = 8.0
    }
    
    func setup() {
        
    }
}
