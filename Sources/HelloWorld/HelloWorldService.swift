//
// Created by Andreas Bauer on 07.11.21.
//

import Foundation
import Apodini
import ApodiniGRPC
import ApodiniProtobuffer

@main
struct HelloWorldService: WebService {
    var content: some Component {
        Greeter()
            .serviceName("Greeter")
            .rpcName("greetName")
    }

    var configuration: Configuration {
        GRPC {
            Protobuffer()
        }

        if let cert = Bundle.module.path(forResource: "cert", ofType: "pem"),
           let key = Bundle.module.path(forResource: "key", ofType: "pem") {
            HTTP2Configuration(cert: cert, keyPath: key)
        }
    }
}

struct Greeter: Handler {
    @Parameter
    var name: String

    func handle() -> String {
        "Hello \(name)"
    }

    // TODO metadata for rpcName and servicename?
}
