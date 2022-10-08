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
