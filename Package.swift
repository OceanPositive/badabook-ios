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
        .library(name: "BadaMacApp", targets: ["BadaMacApp"]),
        .library(name: "BadaCore", targets: ["BadaCore"]),
        .library(name: "BadaData", targets: ["BadaData"]),
        .library(name: "BadaDomain", targets: ["BadaDomain"]),
        .library(name: "BadaUI", targets: ["BadaUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/OneWay.git", exact: "2.7.0"),
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
            dependencies: ["BadaApp"]
        ),
        .target(
            name: "BadaMacApp",
            dependencies: [
                "BadaCore",
                "BadaDomain",
                "BadaUI",
            ]
        ),
        .testTarget(
            name: "BadaMacAppTests",
            dependencies: ["BadaMacApp"]
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
        .target(
            name: "BadaData",
            dependencies: [
                "BadaDomain",
            ]
        ),
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

for target in package.targets {
    target.swiftSettings = target.swiftSettings ?? []
    target.swiftSettings?.append(
        .enableExperimentalFeature("StrictConcurrency")
    )
}
