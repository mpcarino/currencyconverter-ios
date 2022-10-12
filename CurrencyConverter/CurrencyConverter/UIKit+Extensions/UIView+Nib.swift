//
//  UIView+Nib.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import UIKit

extension UIView {
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UIViewController {
  func presentAlert(title: String? = nil, message: String, actions: [UIAlertAction]) {
    let alertController = UIAlertController(
      title: title,
      message: message, preferredStyle: .alert
    )

    for action in actions {
      alertController.addAction(action)
    }
    
    present(alertController, animated: true)
  }
}

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
