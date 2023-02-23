import Combine
import Foundation
import XCTestDynamicOverlay

import Dependencies

/// @mockable
public protocol FooRepository {
    var currentValue: AnyPublisher<Int, Never> { get }
    func increment() async throws
}

public final class FooRepositoryImpl: FooRepository {
    public var currentValue: AnyPublisher<Int, Never> { $value.eraseToAnyPublisher() }
    @Published private var value = 0

    public init() {}

    public func increment() async throws {
        value += 1
    }
}

struct UnimplementedFooRepository: FooRepository {
    var currentValue: AnyPublisher<Int, Never> {
        unimplemented("\(Self.self).currentValue")
    }
    
    func increment() async throws {
        fatalError("unimplemented:\(Self.self).increment")
    }
}

public enum FooRepositoryKey: DependencyKey {
    static public let liveValue: any FooRepository = FooRepositoryImpl()
    static public let previewValue: any FooRepository = UnimplementedFooRepository()
    static public let testValue: any FooRepository = UnimplementedFooRepository()
}

public extension DependencyValues {
    var fooRepository: any FooRepository {
        get { self[FooRepositoryKey.self] }
        set { self[FooRepositoryKey.self] = newValue }
    }
}
