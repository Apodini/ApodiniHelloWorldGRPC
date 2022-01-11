//
// Created by Andreas Bauer on 07.11.21.
//

import Foundation
import NIO
import GRPC

let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
defer {
    try! group.syncShutdownGracefully()
}

let channel = ClientConnection
    .usingTLSBackedByNIOSSL(on: group)
    .withTLS(certificateVerification: .none)
    .connect(host: "127.0.0.1", port: 8080)
defer {
    try! channel.close().wait()
}

let client = GreeterAsyncClient(channel: channel)

let promise: EventLoopPromise<Void> = group.next().makePromise()

promise.completeWithTask {
    let message = GreeterMessage(name: "Andi")

    let call = client.makeGreetNameCall(message)

    let response = try await client.greetName(message)
    print("Response: \(response)")
}

try promise.futureResult.wait()
