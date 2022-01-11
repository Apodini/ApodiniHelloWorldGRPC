//
// Created by Andreas Bauer on 07.11.21.
//

import Foundation
import SwiftProtobuf
import GRPC
import _PB_GENERATED

public typealias SwiftProtobufProtocols = SwiftProtobuf.Message & SwiftProtobuf._MessageImplementationBase & SwiftProtobuf._ProtoNameProviding

// TODO conformance to CustomReflectable

public protocol SwiftProtobufWrapper: SwiftProtobufProtocols {
    associatedtype Wrapped: SwiftProtobufProtocols

    var __wrapped: Wrapped { get set }// TODO access protection!!
    // TODO fileprivate var wrapped: _PB_GENERATED.GreeterMessage

    subscript<T>(dynamicMember member: KeyPath<Wrapped, T>) -> T { get }

    subscript<T>(dynamicMember member: WritableKeyPath<Wrapped, T>) -> T { get set }
}

// MARK - @dynamicMemberLookup
public extension SwiftProtobufWrapper {
    subscript<T>(dynamicMember member: KeyPath<Wrapped, T>) -> T {
        get {
            __wrapped[keyPath: member]
        }
    }

    subscript<T>(dynamicMember member: WritableKeyPath<Wrapped, T>) -> T {
        get {
            __wrapped[keyPath: member]
        }
        set {
            __wrapped[keyPath: member] = newValue
        }
    }
}

// MARK: SwiftProtobufProtocols
public extension SwiftProtobufWrapper {
    public static var protoMessageName: String {
        Wrapped.protoMessageName
    }

    public static var _protobuf_nameMap: _NameMap {
        Wrapped._protobuf_nameMap
    }

    public var unknownFields: UnknownStorage {
        get {
            __wrapped.unknownFields
        }
        set(newValue) {
            __wrapped.unknownFields = newValue
        }
    }

    public mutating func decodeMessage<D: Decoder>(decoder: inout D) throws {
        try __wrapped.decodeMessage(decoder: &decoder)
    }

    public func traverse<V: Visitor>(visitor: inout V) throws {
        try __wrapped.traverse(visitor: &visitor)
    }
}

// ********** generated models
// TODO one drawback with this wrapper method is, that we must generate/mirror all methods defined on the wrapped object
//  less of a problem with the models, but more should we choose a wrapper approach for the grpc stuff!
@dynamicMemberLookup
public struct GreeterMessage: SwiftProtobufWrapper {
    public var __wrapped: _PB_GENERATED.GreeterMessage

    public init() {
        __wrapped = .init()
    }

    // TODO to avoid constant migration between storage type (wrapped GreeterMessage) and exposed type
    //   e.g. old property with different type, we could add additional storage layer and only write in the
    //   wrapped type, when `traverse` or `decode` is called(?)

    public init(
        name: String
    ) {
        self.init()
        __wrapped.name2 = name
    }
}

@dynamicMemberLookup
public struct GreetingMessage: SwiftProtobufWrapper {
    public var __wrapped: _PB_GENERATED.GreetingMessage

    public init() {
        self.__wrapped = .init()
    }

    public init(
        greet: String
    ) {
        self.init()
        __wrapped.greet2 = greet
    }
}
// ************

// TODO property addition: no need
// TODO property renaming: extension with computed property (kinda hard, as we need to cover all grpc generated additional property: e.g. hasName, clearName for name!) => @available tag?
// TODO property removal: extension with computed property (as above!) => @available tag?
// TODO property type change: how to handle that?
//   If it is only a name change of the type => shortcut via typealias again
//   - use a Interface extension approach (double naming) -> only usable if original type is EXPLICITLY defined
//   - use a Wrapper approach with dynamicMemberLookup -> new property isn't accessible without explicit stuff?
//      => possibility make it accessible as a projectValue with a property wrapper approach
// TODO type addition: trivial
// TODO type renaming: typealias!
// TODO type removal: polyfill? or do we just remove it? Fatal error style?

// TODO as soon as we introduce a wrapper type, we need to rename the generated model????
// TODO => pack it into a separate package and introduce typealiases from the beginning on!!

// TODO enum case renaming?

// TODO would be cool to generate @available (stuff into code for proper compiler warning notice)!

func test(message: GreeterMessageWrapper) {
    let oldName = message.name // testing "old" non migrated access
    print(oldName.name)

    let newName = message.$name // migrated access via projected value => fully migrate by removing the wrapper?
    _ = newName.replacingOccurrences(of: "asdf", with: "asdf")
}


@propertyWrapper
struct TypeReplacerProperty<Base, OGType, NewType> {
    var wrapped: Base
    var keyPath: KeyPath<Base, OGType>
    var migration: (OGType) -> NewType

    var wrappedValue: NewType {
        migration(projectedValue)
    }

    var projectedValue: OGType {
        wrapped[keyPath: keyPath]
    }
}

struct PreviousNameType {
    var name: String
}

@dynamicMemberLookup
struct GreeterMessageWrapper {
    let wrapped: GreeterMessage

    @available(*, deprecated, message: "The type of the `name` property has changed to `String`. Use projected value `$name` to access the property with the new type or migrate the model completely!")
    @TypeReplacerProperty<GreeterMessage, String, PreviousNameType>
    var name: PreviousNameType

    init(wrapped: GreeterMessage) {
        self.wrapped = wrapped
        self._name = .init(wrapped: wrapped, keyPath: \.name2, migration: { .init(name: $0) })
    }

    // TODO copy initializers!
    // TODO this is a bit meh, as we need to REACT to new pb generations should inits change!

    subscript<T>(dynamicMember member: KeyPath<GreeterMessage, T>) -> T {
        get {
            wrapped[keyPath: member]
        }
    }
}
