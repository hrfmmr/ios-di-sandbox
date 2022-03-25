@testable import Bravo
import Combine
import Core
import Foundation
import UIKit
import XCTest

class BravoFooVCTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    // MARK: Input

    func testInput_viewDidLoad() throws {
        XCTContext.runActivity(named: "Input::viewDidLoad") { _ in
            let viewContainer = TestBravoFooViewContainerMock()
            let state = BravoFooState()
            let fetchUseCase = FetchFooValueUseCaseMock(
                dependency: .init(
                    gateway: FooRepositoryMock()
                )
            )
            let incrementUseCase = IncrementFooValueUseCaseMock(
                dependency: .init(
                    gateway: FooRepositoryMock()
                )
            )
            let vc: BravoFooVC = .init(dependency: .init(
                viewContainer: AnyViewContainer(viewContainer),
                state: state,
                fetchUseCase: UseCase(fetchUseCase),
                incrementUseCase: UseCase(incrementUseCase)
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

    func testOutput_didTapIncrementFoo() throws {
        XCTContext.runActivity(named: "Output::didTapIncrementFoo") { _ in
            let viewContainer = TestBravoFooViewContainerMock()
            let state = BravoFooState()
            let fetchUseCase = FetchFooValueUseCaseMock(
                dependency: .init(
                    gateway: FooRepositoryMock()
                )
            )
            let incrementUseCase = IncrementFooValueUseCaseMock(
                dependency: .init(
                    gateway: FooRepositoryMock()
                )
            )
            let vc: BravoFooVC = .init(dependency: .init(
                viewContainer: AnyViewContainer(viewContainer),
                state: state,
                fetchUseCase: UseCase(fetchUseCase),
                incrementUseCase: UseCase(incrementUseCase)
            ))
            // preconditions
            do {
                XCTAssertEqual(incrementUseCase.executeCallCount, 0)
            }
            // make context
            let fooValue = 100
            do {
                fetchUseCase.executeHandler = { _ in
                    .success(CurrentValueSubject<Int, Never>(fooValue).eraseToAnyPublisher())
                }
                incrementUseCase.executeHandler = { _ in
                    .success(())
                }
                state.$fooValue
                    .sink { value in
                        guard value == fooValue else { return }
                    }
                    .store(in: &cancellables)
                vc.loadViewIfNeeded()
                viewContainer.sendDidTapIncrementFoo()
            }
            // assertions
            do {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    XCTAssertEqual(incrementUseCase.executeCallCount, 1)
                }
            }
        }
    }
}

/// @mockable
protocol TestBravoFooViewContainer: BravoFooInput, BravoFooOutput {}
extension TestBravoFooViewContainerMock: ViewContainer {
    var input: BravoFooInput { self }
    var output: BravoFooOutput { self }
    var view: UIView { .init() }

    func sendDidTapIncrementFoo() {
        didTapIncrementFooSubject.send(())
    }
}
