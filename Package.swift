// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "when",
    products: [
        .library(
            name: "when",
            targets: ["when"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "when",
            dependencies: []),
        .testTarget(
            name: "whenTests",
            dependencies: ["when"]),
    ]
)
