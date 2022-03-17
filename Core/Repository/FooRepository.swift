import Combine
import Foundation

public protocol FooRepository {
    var currentValue: AnyPublisher<Int, Never> { get }
    func update(value: Int)
}

public final class FooRepositoryImpl: FooRepository {
    public var currentValue: AnyPublisher<Int, Never> { $value.eraseToAnyPublisher() }
    @Published private var value = 0

    public init() {}

    public func update(value: Int) {
        self.value = value
    }
}
