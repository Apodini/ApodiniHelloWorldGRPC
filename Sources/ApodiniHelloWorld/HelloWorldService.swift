//
// Created by Andreas Bauer on 07.11.21.
//

import Foundation
import Apodini
// TODO import ApodiniGRPC
import ApodiniMigration

@main
struct HelloWorldService: WebService {
    let migrated: Bool = true

    var content: some Component {
        // migrated:
        // /*
        MigratedGreeter()
            .identified(by: "Greeter.greetName")
            //.gRPCServiceName("Greeter")
            //.gRPCMethodName("greetName")
        // */

        // non migrated
        /*
        Greeter()
                .serviceName("Greeter")
                .rpcName("greetName")
                .identified(by: "Greeter.greetName")
        // */
    }

    var metadata: Metadata {
        if migrated {
            Version(major: 1, minor: 1)
        } else {
            Version(major: 1)
        }
    }

    var configuration: Configuration {
        if let cert = Bundle.module.path(forResource: "cert", ofType: "pem"),
           let key = Bundle.module.path(forResource: "key", ofType: "pem") {
            HTTPConfiguration(bindAddress: .interface("127.0.0.1", port: 8080), tlsConfigurationBuilder: .init(certificatePath: cert, keyPath: key))
        }

        // TODO grpc dependency removed as it conflicts with our dev version of grpc-swift
        // TODO GRPC(packageName: "HelloWorldPackage", serviceName: "Greeter")

        if migrated {
            Migrator(
                documentConfig: DocumentConfiguration.export(.directory("~/XcodeProjects/TUM/ApodiniHelloWorld/migrator")),
                migrationGuideConfig: .compare(.file("/Users/andi/XcodeProjects/TUM/ApodiniHelloWorld/migrator/api_v1.0.0.json"), export: .directory("~/XcodeProjects/TUM/ApodiniHelloWorld/migrator"))
            )
        } else {
            Migrator(
                documentConfig: DocumentConfiguration.export(.directory("~/XcodeProjects/TUM/ApodiniHelloWorld/migrator"))
            )
        }
    }
}

struct MigratedGreeter: Handler {
    @Parameter
    var name2: String

    func handle() -> Greeting {
        Greeting(stringLiteral: "Hello \(name2)")
    }
}

struct Greeter: Handler {
    @Parameter
    var name: String

    func handle() -> Greeting {
        Greeting(stringLiteral: "Hello \(name)")
    }

    // TODO metadata for rpcName and serviceName?
}

struct Greeting: ExpressibleByStringLiteral, Content, Codable {
    var greet2: String // TODO adjust migration manually
    
    init(stringLiteral: String) {
        self.greet2 = stringLiteral
    }
}
