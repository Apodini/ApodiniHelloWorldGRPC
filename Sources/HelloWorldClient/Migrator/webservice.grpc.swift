// DO NOT EDIT.
//
// This file is machine generated!

import NIO
import GRPC

import Foundation

public enum GRPCNetworkingError: Error {
    case streamingTypeMigrationError(type: StreamingTypeMigrationErrorType)
}

/// Defines errors which might be thrown when a conversion from a
/// service side stream to service side response fails.
public enum StreamingTypeMigrationErrorType {
    /// Thrown if the first next() already fails to yield any response!
    case didNotReceiveAnyResponse
    /// Thrown if the server returned more than one response.
    /// We can't handle such migrations
    case didReceiveToManyResponses
}


/// APODINI-handler: Greeter
/// APODINI-identifier: Greeter.greetName
protocol GreeterAsyncClientProtocol: GRPCClient {
    var serviceName: String { get }
    
    func makeGreetNameCall(
        _ request: GreeterMessage,
        callOptions: CallOptions?
    ) -> GRPCAsyncUnaryCall<GreeterMessage, GreetingMessage>
}



extension AsyncThrowingStream {
    public init<Wrapped: AsyncSequence>(wrapping sequence: Wrapped) where Wrapped.Element == Element, Failure == Error {
        self = AsyncThrowingStream { continuation in
            Task.detached {
                do {
                    for try await value in sequence {
                        continuation.yield(value)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish()
                }
            }
        }
    }

    public init<Wrapped: Sequence>(wrapping sequence: Wrapped) where Wrapped.Element == Element, Failure == Error {
        self = AsyncThrowingStream { continuation in
            for value in sequence {
                continuation.yield(value)
            }
            continuation.finish()
        }
    }
}

public struct GRPCResponseStream<Element>: AsyncSequence {
    public typealias Stream = AsyncThrowingStream<Element, Error>

    private let wrappedStream: Stream

    public init<Wrapped: AsyncSequence>(wrapping sequence: Wrapped) where Wrapped.Element == Element {
        self.wrappedStream = Stream(wrapping: sequence)
    }

    public init<Wrapped: Sequence>(wrapping sequence: Wrapped) where Wrapped.Element == Element {
        self.wrappedStream = Stream(wrapping: sequence)
    }

    public init(_ build: (Stream.Continuation) -> Void) {
        self.wrappedStream = AsyncThrowingStream(Element.self, build)
    }

    public init(stream: Stream) {
        self.wrappedStream = stream
    }

    public func makeAsyncIterator() -> Stream.Iterator {
        wrappedStream.makeAsyncIterator()
    }
}

extension GreeterAsyncClientProtocol {
    var serviceName: String {
        "Greeter"
    }
    
    func makeGreetNameCall(
        _ request: GreeterMessage,
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncUnaryCall<GreeterMessage, GreetingMessage> {
        self.makeAsyncUnaryCall(
            path: "Greeter/greetName",
            request: request,
            callOptions: callOptions ?? defaultCallOptions
        )
    }
}

struct GreeterAsyncClient: GreeterAsyncClientProtocol {
    var channel: GRPCChannel
    var defaultCallOptions: CallOptions
    init(
        channel: GRPCChannel,
        defaultCallOptions: CallOptions = CallOptions()
    ) {
        self.channel = channel
        self.defaultCallOptions = defaultCallOptions
    }
}

extension GreeterAsyncClient {
    func greetName91<RequestStream>(
        _ requests: RequestStream,
        callOptions: CallOptions? = nil
    ) async throws -> GreetingMessage where RequestStream: AsyncSequence, RequestStream.Element == GreeterMessage {
        let stream = requests
            .map { (request: GreeterMessage) -> GreetingMessage in
                let response = try await performAsyncUnaryCall(
                    path: "Greeter/greetName",
                    request: request,
                    callOptions: callOptions ?? defaultCallOptions,
                    responseType: GreetingMessage.self
                )
                return response
            }

        var iterator = stream.makeAsyncIterator()
        guard let result = try await iterator.next() else {
            // TODO no value!
            fatalError("asdf")
        }
        return result
    }

    func greetName92<RequestStream>(
        _ requests: RequestStream,
        callOptions: CallOptions? = nil
    ) async throws -> GreetingMessage where RequestStream: Sequence, RequestStream.Element == GreeterMessage {
        let stream = AsyncThrowingStream(wrapping: requests)
            .map { request -> GreetingMessage in
                try await performAsyncUnaryCall(
                    path: "Greeter/greetName",
                    request: request,
                    callOptions: callOptions ?? defaultCallOptions,
                    responseType: GreetingMessage.self
                )
            }

        var iterator = stream.makeAsyncIterator()
        guard let result = try await iterator.next() else {
            throw GRPCNetworkingError.streamingTypeMigrationError(type: .didNotReceiveAnyResponse)
        }
        return result
    }

    func greetName93<RequestStream>(
        _ requests: RequestStream,
        callOptions: CallOptions? = nil
    ) -> GRPCResponseStream<GreetingMessage> where RequestStream: AsyncSequence, RequestStream.Element == GreeterMessage {
        GRPCResponseStream(wrapping: requests
            .flatMap { element in
                performAsyncServerStreamingCall(
                    path: "Greeter/greetName",
                    request: element,
                    callOptions: callOptions ?? defaultCallOptions,
                    responseType: GreetingMessage.self
                )
            })
    }

    func greetName94<RequestStream>(
        _ requests: RequestStream,
        callOptions: CallOptions? = nil
    ) -> GRPCResponseStream<GreetingMessage> where RequestStream: Sequence, RequestStream.Element == GreeterMessage {
        GRPCResponseStream(wrapping: AsyncThrowingStream(wrapping: requests)
            .flatMap { element in
                performAsyncServerStreamingCall(
                    path: "Greeter/greetName",
                    request: element,
                    callOptions: callOptions ?? defaultCallOptions,
                    responseType: GreetingMessage.self
                )
            })
    }

    
    
    internal func greetName(
        _ request: GreeterMessage,
        callOptions: CallOptions? = nil
    ) async throws -> GreetingMessage {
        try await performAsyncUnaryCall(
            path: "Greeter/greetName",
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            responseType: GreetingMessage.self
        )
    }

    internal func greetName2(
        _ request: GreeterMessage,
        callOptions: CallOptions? = nil
    ) async throws -> GreetingMessage {
        let requests = [request]

        return try await performAsyncClientStreamingCall(
            path: "Greeter/greetName",
            requests: requests,
            callOptions: callOptions ?? defaultCallOptions
        )
    }

    internal func greetName3(
        _ request: GreeterMessage,
        callOptions: CallOptions? = nil
    ) async throws -> GreetingMessage {
        let result = performAsyncServerStreamingCall(
            path: "Greeter/greetName",
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            responseType:  GreetingMessage.self
        )

        let stream = GRPCResponseStream(wrapping: result)

        var iterator = result.makeAsyncIterator()
        guard let response = try await iterator.next() else {
            throw GRPCNetworkingError.streamingTypeMigrationError(type: .didNotReceiveAnyResponse)
        }
        guard try await iterator.next() == nil else {
            throw GRPCNetworkingError.streamingTypeMigrationError(type: .didNotReceiveAnyResponse)
        }
        return response
    }

    internal func greetName4(
        _ request: GreeterMessage,
        callOptions: CallOptions? = nil
    ) -> GRPCResponseStream<GreetingMessage> {
        /*let result = try await performAsyncUnaryCall(
            path: "Greeter/greetName",
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            responseType:  GreetingMessage.self
        )*/

        let result = AsyncStream<String> { continueiation in
            continueiation.yield("asdf")
            continueiation.finish()
        }

        Task.detached {
            for try await eh in result {

            }
        }

        return GRPCResponseStream { continuation in
            Task.detached {
                do {
                    let result = try await performAsyncUnaryCall(
                        path: "Greeter/greetName",
                        request: request,
                        callOptions: callOptions ?? defaultCallOptions,
                        responseType:  GreetingMessage.self
                    )

                    continuation.yield(result)
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}