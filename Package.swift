// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xcutility",
    products: [
        .library(name: "XCUtilityFramework", targets: ["XCUtilityFramework"]),
        .executable(name: "xcutility", targets: ["xcutility"])
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/xcodeproj.git", from: "6.5.0"),
        .package(url: "https://github.com/Carthage/Commandant.git", from: "0.15.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "1.0.1")
    ],
    targets: [
        .target(name: "xcutility", dependencies: ["XCUtilityFramework","Commandant"]),
        .target(name: "XCUtilityFramework", dependencies: ["xcodeproj", "Yams"]),
        .testTarget(name: "XCUtilityFrameworkTests", dependencies: ["XCUtilityFramework"])
    ],
    swiftLanguageVersions: [.v5]
)
