import Combine
import Core
import Foundation

class UpdateFooValueUseCase: UseCaseType {
    typealias Parameters = Int

    struct Dependency {
        let gateway: FooRepository
    }

    private let dependency: Dependency
    private var cancellables = Set<AnyCancellable>()

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func execute(_ parameters: Parameters, completion: ((Result<Void, Error>) -> Void)?) {
        dependency.gateway.update(value: parameters)
        completion?(.success(()))
    }
}
