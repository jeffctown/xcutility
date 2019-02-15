// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xcodemissing",
    products: [
        .library(
            name: "XcodeMissingFramework",
            targets: ["XcodeMissingFramework"]),
        .executable(
            name: "xcodemissing",
            targets: ["xcodemissing"])
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/xcodeproj.git", from: "6.5.0"),
        .package(url: "https://github.com/Carthage/Commandant.git", from: "0.15.0")
    ],
    targets: [
        .target(
            name: "xcodemissing",
            dependencies: ["XcodeMissingFramework","Commandant"]),
        .target(
            name: "XcodeMissingFramework",
            dependencies: ["xcodeproj"]),
        .testTarget(
            name: "XcodeMissingFrameworkTests",
            dependencies: ["XcodeMissingFramework"]),
    ]
)
