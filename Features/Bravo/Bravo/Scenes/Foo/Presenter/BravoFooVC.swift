import Combine
import Core
import UIKit

/// @mockable
protocol BravoFooInput {
    var state: BravoFooState { get set }
}

/// @mockable
protocol BravoFooOutput {
    var didTapIncrementFoo: AnyPublisher<Void, Never> { get }
}

public final class BravoFooVC: UIViewController {
    public struct Dependency {
        let viewContainer: AnyViewContainer<BravoFooInput, BravoFooOutput>
        let state: BravoFooState
        let fetchUseCase: UseCase<Void, AnyPublisher<Int, Never>, Never>
        let incrementUseCase: UseCase<Void, Void, Error>
    }

    private let dependency: Dependency

    // Events
    private var cancellables = Set<AnyCancellable>()

    public init(dependency: Dependency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
        binding()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        view = dependency.viewContainer.view
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = String(describing: type(of: self))
        fetch()
    }

    private func fetch() {
        Task {
            let fetchResult = await dependency.fetchUseCase.execute(())
            switch fetchResult {
            case let .success(publisher):
                publisher
                    .map { Optional($0) }
                    .assign(to: \.fooValue, on: self.dependency.state)
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
        let output = dependency.viewContainer.output
        output.didTapIncrementFoo.sink { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.dependency.incrementUseCase.execute(())
            }
        }
        .store(in: &cancellables)
    }
}
