//
// Created by Andreas Bauer on 07.11.21.
//

import Foundation
import NIO
import GRPC

let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
let channel = ClientConnection
    .usingTLSBackedByNIOSSL(on: group) // TODO .secure(group:)
    .withTLS(certificateVerification: .none)
    .connect(host: "127.0.0.1", port: 8080)

let client = GreeterClient(channel: channel)

var message = GreeterMessage()
message.name = "Andi"

let response = try client.greetName(message).response.wait()

print("Response: \(response.value)")

try channel.close().wait()

try group.syncShutdownGracefully()