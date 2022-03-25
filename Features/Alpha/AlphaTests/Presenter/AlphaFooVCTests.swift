@testable import Alpha
import Combine
import Core
import Foundation
import UIKit
import XCTest

class AlphaFooVCTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    // MARK: Input

    func testInput_viewDidLoad() throws {
        XCTContext.runActivity(named: "Input::viewDidLoad") { _ in
            let viewContainer = TestAlphaFooViewContainerMock()
            let state = AlphaFooState()
            let fetchUseCase = FetchFooValueUseCaseMock(
                dependency: .init(
                    gateway: FooRepositoryMock()
                )
            )
            let router = AlphaFooWireframeMock()
            let vc: AlphaFooVC = .init(dependency: .init(
                viewContainer: AnyViewContainer(viewContainer),
                state: state,
                fetchUseCase: UseCase(fetchUseCase),
                router: router
            ))
            let exp = XCTestExpectation(description: "state.fooValue")
            exp.expectedFulfillmentCount = 1
            // preconditions
            do {
                XCTAssertNil(state.fooValue)
            }
            // make context
            let fooValue = 100
            do {
                fetchUseCase.executeHandler = { _ in
                    .success(CurrentValueSubject<Int, Never>(fooValue).eraseToAnyPublisher())
                }
                state.$fooValue
                    .sink { value in
                        guard value == fooValue else { return }
                        exp.fulfill()
                    }
                    .store(in: &cancellables)
                vc.loadViewIfNeeded()
            }
            // assertions
            do {
                wait(for: [exp], timeout: 1)
            }
        }
    }

    // MARK: Output

    func testOutput_didTapBravoFoo() throws {
        XCTContext.runActivity(named: "Output::didTapBravoFoo") { _ in
            let viewContainer = TestAlphaFooViewContainerMock()
            let state = AlphaFooState()
            let fetchUseCase = FetchFooValueUseCaseMock(
                dependency: .init(
                    gateway: FooRepositoryMock()
                )
            )
            fetchUseCase.executeHandler = { _ in
                .success(CurrentValueSubject<Int, Never>(0).eraseToAnyPublisher())
            }
            let router = AlphaFooWireframeMock()
            let vc: AlphaFooVC = .init(dependency: .init(
                viewContainer: AnyViewContainer(viewContainer),
                state: state,
                fetchUseCase: UseCase(fetchUseCase),
                router: router
            ))
            // preconditions
            do {
                XCTAssertEqual(router.showBravoFooCallCount, 0)
            }
            // make context
            do {
                vc.loadViewIfNeeded()
                viewContainer.sendDidTapBravoFoo()
            }
            // assertions
            do {
                XCTAssertEqual(router.showBravoFooCallCount, 1)
            }
        }
    }
}

/// @mockable
protocol TestAlphaFooViewContainer: AlphaFooInput, AlphaFooOutput {}
extension TestAlphaFooViewContainerMock: ViewContainer {
    var input: AlphaFooInput { self }
    var output: AlphaFooOutput { self }
    var view: UIView { .init() }

    func sendDidTapBravoFoo() {
        didTapBravoFooSubject.send(())
    }
}
