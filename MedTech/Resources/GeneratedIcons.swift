// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Icons {
  internal static let back = ImageAsset(name: "back")
  internal static let beakers = ImageAsset(name: "beakers")
  internal static let calendar = ImageAsset(name: "calendar")
  internal static let calendarTime = ImageAsset(name: "calendarTime")
  internal static let calendarWhite = ImageAsset(name: "calendarWhite")
  internal static let call = ImageAsset(name: "call")
  internal static let callWhite = ImageAsset(name: "callWhite")
  internal static let checkQuestion = ImageAsset(name: "checkQuestion")
  internal static let checkmark = ImageAsset(name: "checkmark")
  internal static let checkmark2 = ImageAsset(name: "checkmark2")
  internal static let childObserve = ImageAsset(name: "childObserve")
  internal static let conclusion = ImageAsset(name: "conclusion")
  internal static let date = ImageAsset(name: "date")
  internal static let doctor = ImageAsset(name: "doctor")
  internal static let domino = ImageAsset(name: "domino")
  internal static let done = ImageAsset(name: "done")
  internal static let downArrow = ImageAsset(name: "downArrow")
  internal static let download = ImageAsset(name: "download")
  internal static let error = ImageAsset(name: "error")
  internal static let extra = ImageAsset(name: "extra")
  internal static let file = ImageAsset(name: "file")
  internal static let hide = ImageAsset(name: "hide")
  internal static let launchScreen = ImageAsset(name: "launchScreen")
  internal static let launchText = ImageAsset(name: "launchText")
  internal static let line = ImageAsset(name: "line")
  internal static let location = ImageAsset(name: "location")
  internal static let logout = ImageAsset(name: "logout")
  internal static let nocontent = ImageAsset(name: "nocontent")
  internal static let notifDay = ImageAsset(name: "notifDay")
  internal static let notifLocation = ImageAsset(name: "notifLocation")
  internal static let notifTime = ImageAsset(name: "notifTime")
  internal static let notification = ImageAsset(name: "notification")
  internal static let onboarding1 = ImageAsset(name: "onboarding1")
  internal static let onboarding2 = ImageAsset(name: "onboarding2")
  internal static let onboarding3 = ImageAsset(name: "onboarding3")
  internal static let onboarding4 = ImageAsset(name: "onboarding4")
  internal static let pencilEdit = ImageAsset(name: "pencilEdit")
  internal static let profileImage = ImageAsset(name: "profileImage")
  internal static let question = ImageAsset(name: "question")
  internal static let time = ImageAsset(name: "time")
  internal static let unhide = ImageAsset(name: "unhide")
  internal static let warning = ImageAsset(name: "warning")
  internal static let xmark = ImageAsset(name: "xmark")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
