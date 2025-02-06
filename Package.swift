// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swift-Reactive-Programming",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.8.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Swift-Reactive-Programming",
            dependencies: ["RxSwift"]
        ),
        .testTarget(
            name: "Swift-Reactive-ProgrammingTests",
            dependencies: ["Swift-Reactive-Programming"]
        ),
    ]
)
