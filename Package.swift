// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IndustrialRevolution",
    products: [
        .library(
            name: "IndustrialRevolution",
            targets: ["IndustrialRevolution"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "IndustrialRevolution",
            dependencies: []),
        .testTarget(
            name: "IndustrialRevolutionTests",
            dependencies: ["IndustrialRevolution"]),
    ]
)
