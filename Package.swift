// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AppPackage",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "BadaApp", targets: ["BadaApp"]),
        .library(name: "BadaCore", targets: ["BadaCore"]),
        .library(name: "BadaData", targets: ["BadaData"]),
        .library(name: "BadaDomain", targets: ["BadaDomain"]),
        .library(name: "BadaUI", targets: ["BadaUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/OneWay.git", exact: "2.6.0"),
    ],
    targets: [
        .target(
            name: "BadaApp",
            dependencies: [
                "BadaCore",
                "BadaDomain",
                "BadaUI",
            ]
        ),
        .testTarget(
            name: "BadaAppTests",
            dependencies: [
                "BadaApp",
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
            dependencies: ["BadaCore"]
        ),

        .target(name: "BadaData"),
        .testTarget(
            name: "BadaDataTests",
            dependencies: ["BadaData"]
        ),

        .target(name: "BadaDomain"),
        .testTarget(
            name: "BadaDomainTests",
            dependencies: ["BadaDomain"]
        ),

        .target(name: "BadaUI"),
        .testTarget(
            name: "BadaUITests",
            dependencies: ["BadaUI"]
        ),
    ]
)
