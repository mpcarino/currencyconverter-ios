//
//  LandingController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/8/22.
//

import Foundation
import UIKit

class LandingController: UIViewController {
  // MARK: - Life Cycle
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      AppDelegate.shared.updateRootController()
    }
  }
}
