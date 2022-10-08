//
//  CurrencyTextField.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import UIKit

import RxSwift
import RxCocoa
import NSObject_Rx

class CurrencyTextField: UITextField {
  var amount: Decimal = .zero
  var currency: Currency = .default
  
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
  
  private func prepare() {
    configure()
    subscribeToEvents()
  }
  
  private func configure() {
    autocapitalizationType = .none
    autocorrectionType = .no
    spellCheckingType = .no
    keyboardType = .decimalPad
    returnKeyType = .done
    enablesReturnKeyAutomatically = true
  }
  
  private func subscribeToEvents() {
    rx.controlEvent(.editingDidBegin)
      .subscribe(onNext: { [unowned self]  in
        self.text = nil
        self.amount = .zero
      })
      .disposed(by: rx.disposeBag)
    
    rx.controlEvent(.editingDidEnd)
      .subscribe(onNext: { [unowned self]  in
        self.formatText()
      })
      .disposed(by: rx.disposeBag)
  }
  
  func formatText() {
    if let text = self.text,
       let decimal = Decimal(string: text) {
      self.amount = decimal
      self.text = self.currency.currencyFormatter.string(amount: self.amount as NSNumber)
    }
  }
}
