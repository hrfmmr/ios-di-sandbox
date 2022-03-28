import Combine
import ComposableArchitecture
import Core
import UIKit

struct AlphaFooState: Equatable, Identifiable {
    let id = UUID()
    var fooValue: Int?
}

enum AlphaFooAction: Equatable {
    case onAppear
    case fetchFooResponse(Result<Int, Never>)
    case showBravoButtonTapped(UIViewController)
}

struct AlphaFooEnvironment {
    let repository: FooRepository
    let router: AlphaFooWireframe
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

typealias AlphaFooReducer = Reducer<AlphaFooState, AlphaFooAction, AlphaFooEnvironment>
let alphaFooReducer = AlphaFooReducer { state, action, environment in
    switch action {
    case .onAppear:
        return environment.repository.currentValue
            .catchToEffect()
            .map(AlphaFooAction.fetchFooResponse)
    case let .fetchFooResponse(.success(value)):
        state.fooValue = value
        return .none
    case let .showBravoButtonTapped(vc):
        environment.router.showBravoFoo(on: vc)
        return .none
    }
}
