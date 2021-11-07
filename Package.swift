// swift-tools-version:5.5

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
        .package(url: "https://github.com/Apodini/Apodini.git", .branch("maintenance/nio-dependency")),
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
                .product(name: "ApodiniOpenAPI", package: "Apodini")
            ],
            resources: [
                .process("cert")
            ]
        ),
        .executableTarget(
            name: "HelloWorldClient",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift")
            ]
        )
    ]
)
