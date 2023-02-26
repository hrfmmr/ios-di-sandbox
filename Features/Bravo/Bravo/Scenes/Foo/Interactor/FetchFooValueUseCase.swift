import Combine
import Foundation

import Dependencies

import Core

/// @mockable
struct FetchFooValueUseCase: UseCaseType {
    @Dependency(\.fooRepository) var gateway

    func execute(_: Void = ()) async -> Result<AnyPublisher<Int, Never>, Never> {
        .success(gateway.currentValue)
    }
}

extension FetchFooValueUseCase: DependencyKey {
    static let liveValue: Self = .init()
}

extension DependencyValues {
    var fetchFooUseCase: FetchFooValueUseCase {
        get { self[FetchFooValueUseCase.self] }
        set { self[FetchFooValueUseCase.self] = newValue }
    }
}
