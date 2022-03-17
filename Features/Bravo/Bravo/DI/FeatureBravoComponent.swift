import Combine
import Core
import Foundation
import NeedleFoundation
import UIKit

public protocol FeatureBravoDependency: Dependency {
    var fooRepository: FooRepository { get }
}

class BravoFooBuilder: Builder<FeatureBravoDependency>, BravoFooBuildable {
    func build() -> UIViewController {
        let state: BravoFooState = .init()
        return BravoFooVC(
            dependency: .init(
                viewContainer: AnyViewContainer(makeViewContainer(state: state)),
                state: state,
                fetchUseCase: fetchUseCase,
                updateUseCase: updateUseCase
            )
        )
    }

    private func makeViewContainer(state: BravoFooState) -> BravoFooView {
        BravoFooView(state: state)
    }

    private var fetchUseCase: UseCase<Void, AnyPublisher<Int, Never>, Never> {
        UseCase(FetchFooValueUseCase(
            dependency: .init(
                gateway: dependency.fooRepository
            )
        ))
    }

    private var updateUseCase: UseCase<Int, Void, Error> {
        UseCase(UpdateFooValueUseCase(
            dependency: .init(
                gateway: dependency.fooRepository
            )
        ))
    }
}

public class FeatureBravoComponent:
    Component<FeatureBravoDependency>,
    FeatureBravo
{
    public func fooBuilder() -> BravoFooBuildable {
        BravoFooBuilder(dependency: dependency)
    }
}
