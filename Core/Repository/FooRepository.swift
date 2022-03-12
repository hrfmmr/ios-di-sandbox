import Foundation

public protocol FooRepository {
    func fetch() -> Int
    func update(value: Int)
}

public final class FooRepositoryImpl: FooRepository {
    private var value: Int

    public init() {
        self.value = 0
    }

    public func fetch() -> Int {
        value
    }

    public func update(value: Int) {
        self.value = value
    }
}
