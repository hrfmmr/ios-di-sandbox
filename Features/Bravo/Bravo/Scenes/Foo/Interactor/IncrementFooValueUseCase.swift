import Combine
import Foundation

import Dependencies

import Core

/// @mockable
struct IncrementFooValueUseCase: UseCaseType {
    typealias Parameters = Void

    @Dependency(\.fooRepository) var gateway

    func execute(_: Parameters = ()) async -> Result<Void, Error> {
        do {
            try await gateway.increment()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}

extension IncrementFooValueUseCase: DependencyKey {
    static let liveValue: Self = .init()
}

extension DependencyValues {
    var incrementFooUseCase: IncrementFooValueUseCase {
        get { self[IncrementFooValueUseCase.self] }
        set { self[IncrementFooValueUseCase.self] = newValue }
    }
}
