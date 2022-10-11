//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `Landing`.
    static let landing = _R.storyboard.landing()
    /// Storyboard `Launch`.
    static let launch = _R.storyboard.launch()
    /// Storyboard `Wallet`.
    static let wallet = _R.storyboard.wallet()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Landing", bundle: ...)`
    static func landing(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.landing)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Launch", bundle: ...)`
    static func launch(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launch)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Wallet", bundle: ...)`
    static func wallet(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.wallet)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 2 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `greenFaded`.
    static let greenFaded = Rswift.ColorResource(bundle: R.hostingBundle, name: "greenFaded")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "greenFaded", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func greenFaded(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.greenFaded, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "greenFaded", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func greenFaded(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.greenFaded.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `InitialUserWallets.json`.
    static let initialUserWalletsJson = Rswift.FileResource(bundle: R.hostingBundle, name: "InitialUserWallets", pathExtension: "json")
    /// Resource file `SupportedCurrencies.json`.
    static let supportedCurrenciesJson = Rswift.FileResource(bundle: R.hostingBundle, name: "SupportedCurrencies", pathExtension: "json")

    /// `bundle.url(forResource: "InitialUserWallets", withExtension: "json")`
    static func initialUserWalletsJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.initialUserWalletsJson
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SupportedCurrencies", withExtension: "json")`
    static func supportedCurrenciesJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.supportedCurrenciesJson
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `WalletTableCell`.
    static let walletTableCell = _R.nib._WalletTableCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "WalletTableCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.walletTableCell) instead")
    static func walletTableCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.walletTableCell)
    }
    #endif

    static func walletTableCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> WalletTableCell? {
      return R.nib.walletTableCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? WalletTableCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `WalletTableCell`.
    static let walletTableCell: Rswift.ReuseIdentifier<WalletTableCell> = Rswift.ReuseIdentifier(identifier: "WalletTableCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 7 localization keys.
    struct localizable {
      /// Value: Convert
      static let convertNavTitle = Rswift.StringResource(key: "convert.nav.title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Currency Converter
      static let appTitle = Rswift.StringResource(key: "app.title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: No
      static let alertButtonNo = Rswift.StringResource(key: "alert.button.no", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: OK
      static let alertButtonOk = Rswift.StringResource(key: "alert.button.ok", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: This transaction has commission rate of %@ which amounts to %@. A total of %@ will be deducted from your balance and you will receive a total of %@.
      static let convertConversionInfo = Rswift.StringResource(key: "convert.conversion-info", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Yes
      static let alertButtonYes = Rswift.StringResource(key: "alert.button.yes", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: http://api.evp.lt/currency/commercial/exchange/%@-%@/%@/latest
      static let endpointCurrencyExchange = Rswift.StringResource(key: "endpoint.currency-exchange", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: Convert
      static func convertNavTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("convert.nav.title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "convert.nav.title"
        }

        return NSLocalizedString("convert.nav.title", bundle: bundle, comment: "")
      }

      /// Value: Currency Converter
      static func appTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("app.title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "app.title"
        }

        return NSLocalizedString("app.title", bundle: bundle, comment: "")
      }

      /// Value: No
      static func alertButtonNo(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("alert.button.no", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "alert.button.no"
        }

        return NSLocalizedString("alert.button.no", bundle: bundle, comment: "")
      }

      /// Value: OK
      static func alertButtonOk(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("alert.button.ok", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "alert.button.ok"
        }

        return NSLocalizedString("alert.button.ok", bundle: bundle, comment: "")
      }

      /// Value: This transaction has commission rate of %@ which amounts to %@. A total of %@ will be deducted from your balance and you will receive a total of %@.
      static func convertConversionInfo(_ value1: String, _ value2: String, _ value3: String, _ value4: String, preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          let format = NSLocalizedString("convert.conversion-info", bundle: hostingBundle, comment: "")
          return String(format: format, locale: applicationLocale, value1, value2, value3, value4)
        }

        guard let (locale, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "convert.conversion-info"
        }

        let format = NSLocalizedString("convert.conversion-info", bundle: bundle, comment: "")
        return String(format: format, locale: locale, value1, value2, value3, value4)
      }

      /// Value: Yes
      static func alertButtonYes(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("alert.button.yes", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "alert.button.yes"
        }

        return NSLocalizedString("alert.button.yes", bundle: bundle, comment: "")
      }

      /// Value: http://api.evp.lt/currency/commercial/exchange/%@-%@/%@/latest
      static func endpointCurrencyExchange(_ value1: String, _ value2: String, _ value3: String, preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          let format = NSLocalizedString("endpoint.currency-exchange", bundle: hostingBundle, comment: "")
          return String(format: format, locale: applicationLocale, value1, value2, value3)
        }

        guard let (locale, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "endpoint.currency-exchange"
        }

        let format = NSLocalizedString("endpoint.currency-exchange", bundle: bundle, comment: "")
        return String(format: format, locale: locale, value1, value2, value3)
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _WalletTableCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = WalletTableCell

      let bundle = R.hostingBundle
      let identifier = "WalletTableCell"
      let name = "WalletTableCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> WalletTableCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? WalletTableCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try landing.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launch.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try wallet.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct landing: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = LandingController

      let bundle = R.hostingBundle
      let landingController = StoryboardViewControllerResource<LandingController>(identifier: "LandingController")
      let name = "Landing"

      func landingController(_: Void = ()) -> LandingController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: landingController)
      }

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "arrow.down") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'arrow.down' is used in storyboard 'Landing', but couldn't be loaded.") } }
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "arrow.up") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'arrow.up' is used in storyboard 'Landing', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.landing().landingController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'landingController' could not be loaded from storyboard 'Landing' as 'LandingController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launch: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "Launch"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct wallet: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let convertController = StoryboardViewControllerResource<ConvertController>(identifier: "ConvertController")
      let name = "Wallet"
      let walletController = StoryboardViewControllerResource<WalletController>(identifier: "WalletController")

      func convertController(_: Void = ()) -> ConvertController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: convertController)
      }

      func walletController(_: Void = ()) -> WalletController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: walletController)
      }

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "arrow.down") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'arrow.down' is used in storyboard 'Wallet', but couldn't be loaded.") } }
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "arrow.up") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'arrow.up' is used in storyboard 'Wallet', but couldn't be loaded.") } }
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "chevron.down") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'chevron.down' is used in storyboard 'Wallet', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "greenFaded", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'greenFaded' is used in storyboard 'Wallet', but couldn't be loaded.") }
        }
        if _R.storyboard.wallet().convertController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'convertController' could not be loaded from storyboard 'Wallet' as 'ConvertController'.") }
        if _R.storyboard.wallet().walletController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'walletController' could not be loaded from storyboard 'Wallet' as 'WalletController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
