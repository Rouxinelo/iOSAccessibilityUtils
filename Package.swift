// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iOSAccessibilityUtils",

    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "iOSAccessibilityUtils",
            targets: ["iOSAccessibilityUtils"]
        ),
    ],
    targets: [
        .target(
            name: "iOSAccessibilityUtils"
        ),
        .testTarget(
            name: "iOSAccessibilityUtilsTests",
            dependencies: ["iOSAccessibilityUtils"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
