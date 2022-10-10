//
//  ConvertController.swift
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

class ConvertController: UIViewController {
  // MARK: - Properties

  var viewModel: ConvertViewModelProtocol!

  // MARK: - IBOutlets

  @IBOutlet private var balanceContainerView: UIView!
  @IBOutlet private var balanceLabel: UILabel!

  @IBOutlet private var sourceContainerVIew: UIView!
  @IBOutlet private var sourceCodeLabel: UILabel!
  @IBOutlet private var sourceAmountTextField: CurrencyTextField!

  @IBOutlet private var destinationContainerView: UIView!
  @IBOutlet private var destinationAmountTextField: CurrencyTextField!
  @IBOutlet private var destinationCodeButton: UIButton!

  @IBOutlet private var convertButton: UIButton!

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    configure()
    setup()
    bind()
  }

  @IBAction func didTapConvertButton(_ sender: Any) {
    presentErrorAlert(message: "here")
  }
}

// MARK: - Configure

private extension ConvertController {
  func configure() {
    balanceContainerView.layer.cornerRadius = 8.0
    sourceContainerVIew.layer.cornerRadius = 10.0
    destinationContainerView.layer.cornerRadius = 10.0
  }
}

// MARK: - Setup

private extension ConvertController {
  func setup() {
    balanceLabel.text = viewModel.sourceWallet.formattedBalance
    sourceCodeLabel.text = viewModel.sourceWallet.currency.code.uppercased()
    destinationCodeButton.setTitle(viewModel.destinationWallet.currency.code.uppercased(), for: .normal)

    sourceAmountTextField.currency = viewModel.sourceWallet.currency
    destinationAmountTextField.currency = viewModel.destinationWallet.currency
  }
}

// MARK: - Binding

private extension ConvertController {
  func bind() {
    bindUI()
    bindModel()
  }

  func bindUI() {
    sourceAmountTextField.rx
      .controlEvent(.editingDidBegin)
      .subscribe(onNext: { [unowned self] in
        self.convertButton.isEnabled = false
      })
      .disposed(by: rx.disposeBag)

    destinationAmountTextField.rx
      .controlEvent(.editingDidBegin)
      .subscribe(onNext: { [unowned self] in
        self.convertButton.isEnabled = false
      })
      .disposed(by: rx.disposeBag)

    sourceAmountTextField.rx
      .controlEvent(.editingDidEnd)
      .subscribe(onNext: { [unowned self] in
        self.viewModel.getSourceCurrencyExchange(for: "\(sourceAmountTextField.amount)")
      })
      .disposed(by: rx.disposeBag)

    destinationAmountTextField.rx
      .controlEvent(.editingDidEnd)
      .subscribe(onNext: { [unowned self] in
        self.viewModel.getDestinationCurrencyExchange(for: "\(destinationAmountTextField.amount)")
      })
      .disposed(by: rx.disposeBag)
  }

  func bindModel() {
    viewModel.contentState
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] contentState in
        switch contentState {
        case .loading:
          SVProgressHUD.show()
        case .ready:
          if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
          }
        case .error:
          SVProgressHUD.showError(withStatus: "")
        }
      })
      .disposed(by: rx.disposeBag)

    viewModel.isValidSourceAmount
      .startWith(false)
      .observe(on: MainScheduler.instance)
      .subscribe({ [unowned self] event in
        switch event {
        case let .next(isValid):
          print(isValid)
          self.convertButton.isEnabled = isValid
        case let .error(error):
          self.convertButton.isEnabled = false
          print(error.localizedDescription)
        default:
          return
        }
      })
      .disposed(by: rx.disposeBag)

    viewModel.sourceCurrencyExchange
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] currencyExchange in
        self.updateCurrencyTextField(
          sourceAmountTextField,
          with: currencyExchange.amount
        )
      })
      .disposed(by: rx.disposeBag)

    viewModel.destinationCurrencyExchange
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] currencyExchange in
        self.updateCurrencyTextField(
          destinationAmountTextField,
          with: currencyExchange.amount
        )
      })
      .disposed(by: rx.disposeBag)
  }
}

// MARK: - Methods

private extension ConvertController {
  func updateCurrencyTextField(
    _ textField: CurrencyTextField,
    with amount: String
  ) {
    textField.text = amount
    textField.formatText()
  }

  func presentErrorAlert(message: String) {
    let alertController = UIAlertController(
      title: "",
      message: message, preferredStyle: .alert
    )

    alertController.addAction(.init(title: nil, style: .default))
  }
}
