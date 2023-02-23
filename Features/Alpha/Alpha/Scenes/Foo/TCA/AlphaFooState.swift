import Combine
import UIKit

import ComposableArchitecture
import Dependencies

import Core

struct AlphaFooReducer: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id = UUID()
        var fooValue: Int?
    }
    
    enum Action: Equatable {
        case onAppear
        case fetchFooResponse(Result<Int, Never>)
        case showBravoButtonTapped(UIViewController)
    }

    @Dependency(\.mainQueue) var mainQueue
    @Dependency(\.fooRepository) var repository
    @Dependency(\.alphaFooRouter.showBravoFoo) var showBravoFoo
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return repository.currentValue
                    .catchToEffect()
                    .map(Action.fetchFooResponse)
            case let .fetchFooResponse(.success(value)):
                state.fooValue = value
                return .none
            case let .showBravoButtonTapped(fromVC):
                showBravoFoo(fromVC)
                return .none
            }
        }
    }
}
