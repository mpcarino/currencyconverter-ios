//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/7/22.
//

import UIKit

import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  static var shared: AppDelegate { UIApplication.shared.delegate as! AppDelegate }

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    App.shared.bootstrap(
      with: application,
      launchOptions: launchOptions
    )

    setupKeyboardManager()

    return true
  }
}

// MARK: - Helpers

private extension AppDelegate {
  func setupKeyboardManager() {
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.enableAutoToolbar = true
    IQKeyboardManager.shared.keyboardDistanceFromTextField = 24.0
  }
}
