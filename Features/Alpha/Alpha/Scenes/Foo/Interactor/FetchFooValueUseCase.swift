import Combine
import Core
import Foundation

class FetchFooValueUseCase: UseCaseType {
    struct Dependency {
        let gateway: FooRepository
    }

    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func execute(_: Void = (), completion: ((Result<AnyPublisher<Int, Never>, Never>) -> Void)?) {
        completion?(.success(dependency.gateway.currentValue))
    }
}
