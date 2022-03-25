import Combine
import Core
import UIKit

/// @mockable
protocol AlphaFooInput {
    var state: AlphaFooState { get set }
}

/// @mockable
protocol AlphaFooOutput {
    var didTapBravoFoo: AnyPublisher<Void, Never> { get }
}

final class AlphaFooVC: UIViewController {
    // MARK: Props

    // DI
    public struct Dependency {
        let viewContainer: AnyViewContainer<AlphaFooInput, AlphaFooOutput>
        let state: AlphaFooState
        let fetchUseCase: UseCase<Void, AnyPublisher<Int, Never>, Never>
        let router: AlphaFooWireframe
    }

    private let dependency: Dependency

    // Events
    @Published private var state: AlphaFooState = .init()
    private let showBravoFooSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Init

    public init(dependency: Dependency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
        binding()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override public func loadView() {
        view = dependency.viewContainer.view
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = String(describing: type(of: self))
        fetch()
    }

    // MARK: impl

    private func fetch() {
        Task {
            switch await dependency.fetchUseCase.execute(()) {
            case let .success(publisher):
                publisher
                    .map { Optional($0) }
                    .assign(to: \.fooValue, on: self.dependency.state)
                    .store(in: &self.cancellables)
            }
        }
    }
}

// MARK: - Binding

private extension AlphaFooVC {
    func binding() {
        bindOutput()
    }

    func bindOutput() {
        let output = dependency.viewContainer.output
        output.didTapBravoFoo.sink { [weak self] _ in
            guard let self = self else { return }
            self.dependency.router.showBravoFoo(on: self)
        }
        .store(in: &cancellables)
    }
}
