// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WLNetwork",
    platforms: [
        .macOS(.v13),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "WLNetwork",
            targets: ["WLNetwork"]),
    ],
    targets: [
        .target(
            name: "WLNetwork"),
        .testTarget(
            name: "WLNetworkTests",
            dependencies: ["WLNetwork"]),
    ]
)
