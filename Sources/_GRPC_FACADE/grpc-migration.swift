//
// Created by Andreas Bauer on 15.11.21.
//

import _PB_FACADE // TODO needed?
import _GRPC_GENERATED

// ******* generated clients
public typealias GreeterClientProtocol = _GRPC_GENERATED.GreeterClientProtocol
public typealias GreeterClient = _GRPC_GENERATED.GreeterClient

public typealias GreeterAsyncClientProtocol = _GRPC_GENERATED.GreeterAsyncClientProtocol
public typealias GreeterAsyncClient = _GRPC_GENERATED.GreeterAsyncClient

public typealias GreeterClientInterceptorFactoryProtocol = _GRPC_GENERATED.GreeterClientInterceptorFactoryProtocol
// *******

/*
// MODEL extensions
public extension GreeterAsyncClientProtocol {
    func greetName(
        _ request: GreeterMessage,
        callOptions: CallOptions?
    ) async throws -> GreetingMessage { // TODO wrap response if needed again!
        try await self.greetName(request.wrapped, callOptions: callOptions)
    }
}
*/

