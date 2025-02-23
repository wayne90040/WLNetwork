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
        .library(name: "WLNetwork", targets: ["WLNetwork"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/multipart-kit.git", from: "4.7.1"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "WLNetwork",
            dependencies: [
                .product(name: "MultipartKit", package: "multipart-kit"),
                .product(name: "NIOFoundationCompat", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "WLNetworkTests",
            dependencies: ["WLNetwork"]),
    ]
)
