import Combine
import Core
import Foundation

/// @mockable
class FetchFooValueUseCase: UseCaseType {
    struct Dependency {
        let gateway: FooRepository
    }

    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func execute(_: Void = ()) async -> Result<AnyPublisher<Int, Never>, Never> {
        .success(dependency.gateway.currentValue)
    }
}
