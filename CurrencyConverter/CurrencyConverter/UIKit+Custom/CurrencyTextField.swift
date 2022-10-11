//
//  CurrencyTextField.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import UIKit

import NSObject_Rx
import RxCocoa
import RxSwift

class CurrencyTextField: UITextField {
  // MARK: - Properties

  private let generator = UIImpactFeedbackGenerator(style: .light)

  var amount: Decimal = .zero

  var currency: Currency = .default {
    didSet {
      updatePlaceHolder()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    prepare()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    prepare()
  }
}

// MARK: - Rx

private extension CurrencyTextField {
  private func bind() {
    rx.controlEvent(.editingDidBegin)
      .subscribe(onNext: { [unowned self] in
        self.text = nil
        self.amount = .zero
      })
      .disposed(by: rx.disposeBag)

    rx.controlEvent(.editingDidEnd)
      .subscribe(onNext: { [unowned self] in
        self.formatText()
      })
      .disposed(by: rx.disposeBag)

    rx.controlEvent(.editingChanged)
      .subscribe(onNext: { [unowned self] in
        generator.impactOccurred()
      })
      .disposed(by: rx.disposeBag)
  }
}

// MARK: - Methods

extension CurrencyTextField {
  func formatText() {
    if let text = text,
       let decimal = Decimal(string: text) {
      amount = decimal
      self.text = currency.currencyFormatter.string(amount: amount as NSNumber)
    }
  }
}

// MARK: - Helpers

private extension CurrencyTextField {
  func prepare() {
    configure()
    bind()
  }

  func configure() {
    autocapitalizationType = .none
    autocorrectionType = .no
    spellCheckingType = .no
    keyboardType = .decimalPad
    returnKeyType = .done
    enablesReturnKeyAutomatically = true
  }

  func updatePlaceHolder() {
    placeholder = currency.currencyFormatter.string(amount: NSNumber(value: 0.0))
  }
}
