//
//  CurrencyTableDelegate.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

class CurrencyTableDelegate: NSObject, UITableViewDelegate {
    // MARK: - Properties
    
    var onSelect: ((IndexPath) -> Void) = { _ in }
    
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect(indexPath)
    }
}

