//
//  UIAlertAction.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import UIKit

extension UIAlertAction {
  static var ok: UIAlertAction {
    .init(title: S.alertButtonOk(), style: .default)
  }
  
  static var no: UIAlertAction {
    .init(title: S.alertButtonNo(), style: .default)
  }
  
  static var yes: UIAlertAction {
    .init(title: S.alertButtonYes(), style: .default)
  }
}
