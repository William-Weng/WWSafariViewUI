// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSafariViewUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "WWSafariViewUI", targets: ["WWSafariViewUI"]),
    ],
    targets: [
        .target(name: "WWSafariViewUI", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
