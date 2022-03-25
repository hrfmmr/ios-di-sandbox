import Combine
import Foundation

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
