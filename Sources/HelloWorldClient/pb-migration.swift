//
// Created by Andreas Bauer on 07.11.21.
//

import Foundation

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

protocol Interface {}

extension Interface where Self == GreeterMessage {
    var name: String {
        self.name
    }
}
extension GreeterMessage: Interface {}

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
        self._name = .init(wrapped: wrapped, keyPath: \.name, migration: { .init(name: $0) })
    }

    // TODO copy initializers!
    // TODO this is a bit meh, as we need to REACT to new pb generations should inits change!

    subscript<T>(dynamicMember member: KeyPath<GreeterMessage, T>) -> T {
        get {
            wrapped[keyPath: member]
        }
    }
}
