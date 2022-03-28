@testable import Alpha
import Combine
import ComposableArchitecture
import Foundation
import XCTest

class AlphaFooStateTests: XCTestCase {
    let scheduler = DispatchQueue.test

    func test_onAppear() throws {
        let repository = FooRepositoryMock()
        let router = AlphaFooWireframeMock()
        let store: TestStore = .init(
            initialState: .init(),
            reducer: alphaFooReducer,
            environment: .init(
                repository: repository,
                router: router,
                mainQueue: scheduler.eraseToAnyScheduler()
            )
        )

        let fooValue1 = 1
        let fooValue2 = 2
        do {
            // assertions
            store.send(.onAppear)
            repository.currentValueSubject.send(fooValue1)
            repository.currentValueSubject.send(fooValue2)
            repository.currentValueSubject.send(completion: .finished)
            store.receive(.fetchFooResponse(.success(fooValue1))) {
                $0.fooValue = fooValue1
            }
            store.receive(.fetchFooResponse(.success(fooValue2))) {
                $0.fooValue = fooValue2
            }
        }
    }

    func test_showBravoButtonTapped() throws {
        let repository = FooRepositoryMock()
        let router = AlphaFooWireframeMock()
        let store: TestStore = .init(
            initialState: .init(),
            reducer: alphaFooReducer,
            environment: .init(
                repository: repository,
                router: router,
                mainQueue: scheduler.eraseToAnyScheduler()
            )
        )

        do {
            // preconditions
            precondition(router.showBravoFooArgValues.isEmpty)
            precondition(router.showBravoFooCallCount == 0)
        }
        do {
            // assertions
            let vc: UIViewController = .init()
            store.send(.showBravoButtonTapped(vc))
            XCTAssertEqual([vc], router.showBravoFooArgValues)
            XCTAssertEqual(1, router.showBravoFooCallCount)
        }
    }
}
