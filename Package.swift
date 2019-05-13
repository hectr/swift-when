// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "when",
    products: [
        .library(
            name: "when",
            targets: ["when"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hectr/swift-idioms.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "when",
            dependencies: ["Idioms"]),
        .testTarget(
            name: "whenTests",
            dependencies: ["when"]),
    ]
)
