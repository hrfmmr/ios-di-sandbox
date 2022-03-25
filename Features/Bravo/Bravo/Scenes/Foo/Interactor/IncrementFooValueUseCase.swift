import Combine
import Core
import Foundation

/// @mockable
class IncrementFooValueUseCase: UseCaseType {
    typealias Parameters = Void

    struct Dependency {
        let gateway: FooRepository
    }

    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func execute(_: Parameters = ()) async -> Result<Void, Error> {
        do {
            try await dependency.gateway.increment()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
