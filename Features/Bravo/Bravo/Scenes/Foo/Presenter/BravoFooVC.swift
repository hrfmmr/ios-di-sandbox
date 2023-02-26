import Combine
import Core
import UIKit

import Dependencies

/// @mockable
protocol BravoFooInput {
    var state: BravoFooState { get set }
}

/// @mockable
protocol BravoFooOutput {
    var didTapIncrementFoo: AnyPublisher<Void, Never> { get }
}

public final class BravoFooVC: UIViewController {
    @Dependencies.Dependency(\.fooState) var state
    @Dependencies.Dependency(\.fetchFooUseCase) var fetchUseCase
    @Dependencies.Dependency(\.incrementFooUseCase) var incrementUseCase
    @Dependencies.Dependency(\.mainQueue) var mainQueue
    private lazy var viewContainer: AnyViewContainer<BravoFooInput, BravoFooOutput> = .init(BravoFooView(state: state))

    // Events
    private var cancellables = Set<AnyCancellable>()

    public init() {
        super.init(nibName: nil, bundle: nil)
        binding()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        view = viewContainer.view
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = String(describing: type(of: self))
        fetch()
    }

    private func fetch() {
        Task {
            let fetchResult = await fetchUseCase.execute(())
            switch fetchResult {
            case let .success(publisher):
                publisher
                    .receive(on: mainQueue)
                    .map { Optional($0) }
                    .assign(to: \.fooValue, on: self.state)
                    .store(in: &self.cancellables)
            }
        }
    }
}

private extension BravoFooVC {
    func binding() {
        bindOutput()
    }

    func bindOutput() {
        let output = viewContainer.output
        output.didTapIncrementFoo.sink { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.incrementUseCase.execute(())
            }
        }
        .store(in: &cancellables)
    }
}
