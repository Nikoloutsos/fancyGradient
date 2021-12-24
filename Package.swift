// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FancyGradient",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "FancyGradient", targets: ["FancyGradient"]),
    ],
    targets: [
        .target(name: "FancyGradient", dependencies: []),
        .testTarget(name: "FancyGradientTests", dependencies: ["FancyGradient"]),
    ]
)
