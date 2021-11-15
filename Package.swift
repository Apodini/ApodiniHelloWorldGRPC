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
        .executable(name: "HelloWorld", targets: ["HelloWorld"])
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .upToNextMinor(from: "0.5.2")),
        .package(url: "https://github.com/grpc/grpc-swift.git", .exact("1.4.1-async-await.3"))
    ],
    targets: [
        .executableTarget(
            name: "HelloWorld",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniGRPC", package: "Apodini"),
                .product(name: "ApodiniProtobuffer", package: "Apodini"),
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
                .target(name: "PB.SWIFT"),
                .target(name: "GRPC.SWIFT")
            ]
        ),
        .target(
            name: "PB.SWIFT",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift")
            ]
        ),
        .target(
            name: "GRPC.SWIFT",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift"),
                .target(name: "PB.SWIFT"),
            ]
        )
    ]
)
