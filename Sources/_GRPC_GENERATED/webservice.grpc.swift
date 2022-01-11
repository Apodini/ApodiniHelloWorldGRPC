//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: webservice.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf

// TODO needs to be generated
import _PB_FACADE

/// APODINI-handler: Greeter
/// APODINI-identifier: Greeter.greetName
///
/// Usage: instantiate `GreeterClient`, then call methods of this protocol to make API calls.
public protocol GreeterClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: GreeterClientInterceptorFactoryProtocol? { get }

  func greetName(
    _ request: GreeterMessage,
    callOptions: CallOptions?
  ) -> UnaryCall<GreeterMessage, GreetingMessage>
}

extension GreeterClientProtocol {
  public var serviceName: String {
    return "Greeter"
  }

  /// Unary call to greetName
  ///
  /// - Parameters:
  ///   - request: Request to send to greetName.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func greetName(
    _ request: GreeterMessage,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<GreeterMessage, GreetingMessage> {
    return self.makeUnaryCall(
      path: "/Greeter/greetName",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makegreetNameInterceptors() ?? []
    )
  }
}

public protocol GreeterClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'greetName'.
  func makegreetNameInterceptors() -> [ClientInterceptor<GreeterMessage, GreetingMessage>]
}

public final class GreeterClient: GreeterClientProtocol {
  public let channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: GreeterClientInterceptorFactoryProtocol?

  /// Creates a client for the Greeter service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: GreeterClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#if compiler(>=5.5) && canImport(_Concurrency)
/// APODINI-handler: Greeter
/// APODINI-identifier: Greeter.greetName
@available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
public protocol GreeterAsyncClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: GreeterClientInterceptorFactoryProtocol? { get }

  func makegreetNameCall(
    _ request: GreeterMessage,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<GreeterMessage, GreetingMessage>
}

@available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
extension GreeterAsyncClientProtocol {
  public var serviceName: String {
    return "Greeter"
  }

  public var interceptors: GreeterClientInterceptorFactoryProtocol? {
    return nil
  }

  public func makegreetNameCall(
    _ request: GreeterMessage,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<GreeterMessage, GreetingMessage> {
    return self.makeAsyncUnaryCall(
      path: "/Greeter/greetName",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makegreetNameInterceptors() ?? []
    )
  }
}

@available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
extension GreeterAsyncClientProtocol {
  public func greetName(
    _ request: GreeterMessage,
    callOptions: CallOptions? = nil
  ) async throws -> GreetingMessage {
    return try await self.performAsyncUnaryCall(
      path: "/Greeter/greetName",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makegreetNameInterceptors() ?? []
    )
  }
}

@available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
public struct GreeterAsyncClient: GreeterAsyncClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: GreeterClientInterceptorFactoryProtocol?

  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: GreeterClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#endif // compiler(>=5.5) && canImport(_Concurrency)

