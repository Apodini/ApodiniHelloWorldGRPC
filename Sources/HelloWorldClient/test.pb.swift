// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: test.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public struct TestMessage {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var nameOne: String = String()

  public var nameTwo: String {
    get {return _nameTwo ?? String()}
    set {_nameTwo = newValue}
  }
  /// Returns true if `nameTwo` has been explicitly set.
  public var hasNameTwo: Bool {return self._nameTwo != nil}
  /// Clears the value of `nameTwo`. Subsequent reads from it will return its default value.
  public mutating func clearNameTwo() {self._nameTwo = nil}

  public var asdf: TestMessage.OneOf_Asdf? = nil

  public var asdf32: Int32 {
    get {
      if case .asdf32(let v)? = asdf {return v}
      return 0
    }
    set {asdf = .asdf32(newValue)}
  }

  public var asdf64: Int64 {
    get {
      if case .asdf64(let v)? = asdf {return v}
      return 0
    }
    set {asdf = .asdf64(newValue)}
  }

  public var etc: InnerMessage {
    get {return _etc ?? InnerMessage()}
    set {_etc = newValue}
  }
  /// Returns true if `etc` has been explicitly set.
  public var hasEtc: Bool {return self._etc != nil}
  /// Clears the value of `etc`. Subsequent reads from it will return its default value.
  public mutating func clearEtc() {self._etc = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum OneOf_Asdf: Equatable {
    case asdf32(Int32)
    case asdf64(Int64)

  #if !swift(>=4.1)
    public static func ==(lhs: TestMessage.OneOf_Asdf, rhs: TestMessage.OneOf_Asdf) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.asdf32, .asdf32): return {
        guard case .asdf32(let l) = lhs, case .asdf32(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.asdf64, .asdf64): return {
        guard case .asdf64(let l) = lhs, case .asdf64(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  public struct Test {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var asdf: String = String()

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public init() {}

  fileprivate var _nameTwo: String? = nil
  fileprivate var _etc: InnerMessage? = nil
}

public struct InnerMessage {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var test: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension TestMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = "TestMessage"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "nameOne"),
    2: .same(proto: "nameTwo"),
    3: .same(proto: "asdf32"),
    4: .same(proto: "asdf64"),
    5: .same(proto: "etc"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.nameOne) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._nameTwo) }()
      case 3: try {
        var v: Int32?
        try decoder.decodeSingularInt32Field(value: &v)
        if let v = v {
          if self.asdf != nil {try decoder.handleConflictingOneOf()}
          self.asdf = .asdf32(v)
        }
      }()
      case 4: try {
        var v: Int64?
        try decoder.decodeSingularInt64Field(value: &v)
        if let v = v {
          if self.asdf != nil {try decoder.handleConflictingOneOf()}
          self.asdf = .asdf64(v)
        }
      }()
      case 5: try { try decoder.decodeSingularMessageField(value: &self._etc) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.nameOne.isEmpty {
      try visitor.visitSingularStringField(value: self.nameOne, fieldNumber: 1)
    }
    try { if let v = self._nameTwo {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    switch self.asdf {
    case .asdf32?: try {
      guard case .asdf32(let v)? = self.asdf else { preconditionFailure() }
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 3)
    }()
    case .asdf64?: try {
      guard case .asdf64(let v)? = self.asdf else { preconditionFailure() }
      try visitor.visitSingularInt64Field(value: v, fieldNumber: 4)
    }()
    case nil: break
    }
    try { if let v = self._etc {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TestMessage, rhs: TestMessage) -> Bool {
    if lhs.nameOne != rhs.nameOne {return false}
    if lhs._nameTwo != rhs._nameTwo {return false}
    if lhs.asdf != rhs.asdf {return false}
    if lhs._etc != rhs._etc {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TestMessage.Test: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = TestMessage.protoMessageName + ".Test"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    7: .same(proto: "asdf"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 7: try { try decoder.decodeSingularStringField(value: &self.asdf) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.asdf.isEmpty {
      try visitor.visitSingularStringField(value: self.asdf, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TestMessage.Test, rhs: TestMessage.Test) -> Bool {
    if lhs.asdf != rhs.asdf {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension InnerMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = "InnerMessage"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "test"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.test) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.test.isEmpty {
      try visitor.visitSingularStringField(value: self.test, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: InnerMessage, rhs: InnerMessage) -> Bool {
    if lhs.test != rhs.test {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
