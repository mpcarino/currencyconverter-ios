//
//  AppDelegate+RootController.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import Foundation
import UIKit

extension AppDelegate {
  func updateRootController() {
    setRootToWallet()
  }

  func setRootToWallet() {
    let navigationController = R.storyboard.wallet.instantiateInitialViewController()
    
    let walletController = navigationController?.viewControllers.first as! WalletController
    walletController.viewModel = WalletViewModel(
      user: App.shared.user
    )
    
    window?.rootViewController = navigationController
  }
}
