// swift-tools-version: 6.3

import PackageDescription

let package = Package(
  name: "can",
  platforms: [.macOS(.v13)],
  targets: [.executableTarget(name: "can")],
  swiftLanguageModes: [.v6]
)
