//
//  UIViewController+.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/12/22.
//

import UIKit

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
