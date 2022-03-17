import Combine
import Core
import UIKit

public final class BravoFooVC: UIViewController {
    public struct Dependency {
        let viewContainer: AnyViewContainer<BravoFooInput, BravoFooOutput>
        let state: BravoFooState
        let fetchUseCase: UseCase<Void, AnyPublisher<Int, Never>, Never>
        let updateUseCase: UseCase<Int, Void, Error>
    }
    
    private let dependency: Dependency

    // Events
    private var cancellables = Set<AnyCancellable>()
    
    public init(dependency: Dependency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        view = dependency.viewContainer.view
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = String(describing: type(of: self))
        fetch()
    }
    
    private func fetch() {
        dependency.fetchUseCase.execute(()) { [weak self] result in
            guard let self = self else { return }
            switch result {
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
            guard let self = self, let currentValue = self.dependency.state.fooValue else { return }
            let value = currentValue + 1
            self.dependency.updateUseCase.execute(value, completion: nil)
        }
        .store(in: &cancellables)
    }
}
