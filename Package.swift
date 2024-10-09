// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppPackage",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(name: "BadaApp", targets: ["BadaApp"]),
        .library(name: "BadaCore", targets: ["BadaCore"]),
        .library(name: "BadaData", targets: ["BadaData"]),
        .library(name: "BadaDomain", targets: ["BadaDomain"]),
        .library(name: "BadaUI", targets: ["BadaUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/OneWay.git", exact: "2.9.0"),
    ],
    targets: [
        .target(
            name: "BadaApp",
            dependencies: [
                "BadaCore",
                "BadaData",
                "BadaDomain",
                "BadaUI",
            ]
        ),
        .testTarget(
            name: "BadaAppTests",
            dependencies: [
                "BadaApp",
                "BadaTesting",
            ]
        ),
        .target(
            name: "BadaCore",
            dependencies: [
                "OneWay",
            ]
        ),
        .testTarget(
            name: "BadaCoreTests",
            dependencies: [
                "BadaCore",
                "BadaTesting",
            ]
        ),
        .target(
            name: "BadaData",
            dependencies: [
                "BadaCore",
                "BadaDomain",
            ]
        ),
        .testTarget(
            name: "BadaDataTests",
            dependencies: [
                "BadaData",
                "BadaTesting",
            ]
        ),
        .target(
            name: "BadaDomain",
            dependencies: [
                "BadaCore",
            ]
        ),
        .testTarget(
            name: "BadaDomainTests",
            dependencies: [
                "BadaDomain",
                "BadaTesting",
            ]
        ),
        .target(
            name: "BadaUI",
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "BadaUITests",
            dependencies: [
                "BadaUI",
                "BadaTesting",
            ]
        ),
        .target(
            name: "BadaTesting",
            dependencies: [
                .product(name: "OneWayTesting", package: "OneWay"),
            ]
        ),
    ]
)
