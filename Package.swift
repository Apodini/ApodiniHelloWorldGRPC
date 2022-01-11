// swift-tools-version:5.5

//
// This source file is part of the Apodini open source project
// 
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import PackageDescription

let package = Package(
    name: "ApodiniHelloWorld",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "ApodiniHelloWorld", targets: ["ApodiniHelloWorld"])
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .upToNextMinor(from: "0.6.2")),
        .package(url: "https://github.com/grpc/grpc-swift.git", .exact("1.6.0-async-await.1"))
    ],
    targets: [
        .executableTarget(
            name: "ApodiniHelloWorld",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniGRPC", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniOpenAPI", package: "Apodini"),
                .product(name: "ApodiniMigration", package: "Apodini")
            ],
            resources: [
                .process("cert")
            ]
        ),
        .executableTarget(
            name: "HelloWorldClient",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift"),
                .target(name: "_PB_FACADE"),
                .target(name: "_GRPC_FACADE")
            ]
        ),
        .target(
            name: "_PB_GENERATED",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift")
            ]
        ),
        .target(
            name: "_PB_FACADE",
            dependencies: [
                .target(name: "_PB_GENERATED")
            ]
        ),

        .target(
            name: "_GRPC_GENERATED",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift"),
                .target(name: "_PB_FACADE"),
            ]
        ),

        .target(
            name: "_GRPC_FACADE",
            dependencies: [
                .target(name: "_GRPC_GENERATED")
            ]
        )
    ]
)
