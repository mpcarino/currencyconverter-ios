//
//  UITableViewCell+.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    static var preferredHeight: CGFloat {
        UITableView.automaticDimension
    }
}
