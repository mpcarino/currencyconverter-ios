//
//  ConvertController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa
import NSObject_Rx

class ConvertController: UIViewController {
  // MARK: - Properties
  
  var viewModel: ConvertViewModelProtocol!

  // MARK: - IBOutlets
  
  @IBOutlet private var balanceContainerView: UIView!
  @IBOutlet private var balanceLabel: UILabel!
  
  @IBOutlet private var sourceContainerVIew: UIView!
  @IBOutlet private var sourceCodeLabel: UILabel!
  @IBOutlet private var sourceAmountTextField: UITextField!
  
  @IBOutlet private var destinationContainerView: UIView!
  @IBOutlet private var destinationAmountTextField: UITextField!
  @IBOutlet private var destinationCodeButton: UIButton!
 
  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    setup()
    bind()
  }
  @IBAction func didTapConvertButton(_ sender: Any) {
//    if let sourceAmountText = sourceAmountTextField.text {
//      viewModel.getCurrencyExchange(for: sourceAmountText)
//    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

// MARK: - Setup

private extension ConvertController {
  func configureUI() {
    balanceContainerView.layer.cornerRadius = 8.0
    sourceContainerVIew.layer.cornerRadius = 10.0
    destinationContainerView.layer.cornerRadius = 10.0
  }

  func setup() {
    balanceLabel.text = viewModel.sourceWallet.formattedBalance
    sourceCodeLabel.text = viewModel.sourceWallet.currency.code.uppercased()
    destinationCodeButton.setTitle(viewModel.destinationWallet.currency.code.uppercased(), for: .normal)
  }
}

// MARK: - Binding

private extension ConvertController {
  func bind() {
    sourceAmountTextField.rx
      .text
      .orEmpty
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] text in
        self.viewModel.getCurrencyExchange(
          for: text,
          source: self.viewModel.sourceWallet,
          destination: self.viewModel.destinationWallet
        )
      })
      .disposed(by: rx.disposeBag)
    
    destinationAmountTextField.rx
      .text
      .orEmpty
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] text in
        self.viewModel.getCurrencyExchange(
          for: text,
          source: self.viewModel.destinationWallet,
          destination: self.viewModel.sourceWallet
        )
      })
      .disposed(by: rx.disposeBag)
  }
}
