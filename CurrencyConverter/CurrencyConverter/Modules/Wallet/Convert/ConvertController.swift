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

  private lazy var currencyPickerView: UIPickerView = {
    let pickerView = UIPickerView()

    return pickerView
  }()

  // MARK: - IBOutlets

  @IBOutlet private(set) var balanceContainerView: UIView!
  @IBOutlet private(set) var balanceLabel: UILabel!

  @IBOutlet private(set) var sourceContainerVIew: UIView!
  @IBOutlet private(set) var sourceCodeLabel: UILabel!
  @IBOutlet private(set) var sourceAmountTextField: CurrencyTextField!

  @IBOutlet private(set) var destinationContainerView: UIView!
  @IBOutlet private(set) var destinationAmountTextField: CurrencyTextField!
  @IBOutlet private(set) var destinationCurrencyTextField: UITextField!
  @IBOutlet private(set) var destinationCurrencyButton: UIButton!
  
  @IBOutlet private(set) var infoLabel: UILabel!
  
  @IBOutlet private var convertButton: UIButton!

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    configure()
    setup()
    bind()
  }

  @IBAction func didTapConvertButton(_ sender: Any) {
    viewModel.convert()
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
    setupLabels()
    setupTextFields()
    setupHandlers()
  }

  func setupLabels() {
    balanceLabel.text = viewModel.sourceWallet.formattedBalance
    sourceCodeLabel.text = viewModel.sourceWallet.currency.code.uppercased()
  }

  func setupTextFields() {
    sourceAmountTextField.currency = viewModel.sourceWallet.currency
    destinationAmountTextField.currency = viewModel.destinationWallet.currency
    destinationCurrencyButton.setTitle(viewModel.destinationWallet.currency.code.uppercased(), for: .normal)

    destinationCurrencyTextField.inputView = currencyPickerView
    currencyPickerView.delegate = self
    currencyPickerView.dataSource = self
  }
  
  func setupHandlers() {
    viewModel.onUpdateSourceAmount = handleUpdateSourceAmount()
    viewModel.onUpdateDestinationAmount = handleUpdateDestinationAmount()
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
        guard self.isValidTextInput(from: sourceAmountTextField) else { return }

        self.viewModel.exchangeSourceToDestination(for: sourceAmountTextField.amount)
      })
      .disposed(by: rx.disposeBag)

    destinationAmountTextField.rx
      .controlEvent(.editingDidEnd)
      .subscribe(onNext: { [unowned self] in
        guard self.isValidTextInput(from: destinationAmountTextField) else { return }

        self.viewModel.exchangeDestinationToSource(for: destinationAmountTextField.amount)
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
          SVProgressHUD.dismiss()
        case .success:
          SVProgressHUD.dismiss()
          
          balanceLabel.text = viewModel.sourceWallet.formattedBalance
          sourceAmountTextField.text = nil
          destinationAmountTextField.text = nil
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
    
    viewModel.conversionInfo
      .startWith(.empty)
      .observe(on: MainScheduler.instance)
      .subscribe({ [unowned self] event in
        
        switch event {
        case let .next(info):
          self.infoLabel.text = info
        case let .error(error):
          self.infoLabel.text = error.localizedDescription
        default:
          return
        }
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

  func updateDestinationCurrency() {
    destinationCurrencyButton.setTitle(viewModel.destinationWallet.currency.code.uppercased(), for: .normal)
    destinationAmountTextField.currency = viewModel.destinationWallet.currency
    
    viewModel.exchangeSourceToDestination(for: sourceAmountTextField.amount)
  }

  func isValidTextInput(from textField: UITextField) -> Bool {
    guard let text = textField.text?.trimmingCharacters(in: .whitespaces),
          text.count > 0 else { return false }

    return true
  }

  func presentErrorAlert(message: String) {
    let alertController = UIAlertController(
      title: "",
      message: message, preferredStyle: .alert
    )

    alertController.addAction(.init(title: S.alertButtonOk(), style: .default))
    
    present(alertController, animated: true)
  }
}

// MARK: - Handlers

private extension ConvertController {
  func handleUpdateSourceAmount() -> ((Decimal) -> Void) {
    return { [weak self] amount in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        self.updateCurrencyTextField(
          self.sourceAmountTextField,
          with: "\(amount)"
        )
      }
    }
  }
  
  func handleUpdateDestinationAmount() -> ((Decimal) -> Void) {
    return { [weak self] amount in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        self.updateCurrencyTextField(
          self.destinationAmountTextField,
          with: "\(amount)"
        )
      }
    }
  }
}

// MARK: - UIPickerViewDataSourc, UIPickerViewDelegate

extension ConvertController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return viewModel.supportedCurrencies.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return viewModel.getSupportedCurrencyText(at: row)
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    viewModel.changeDestinationWallet(to: row)
    updateDestinationCurrency()
  }
}
