import Foundation
import Combine
import UIKit
import NeedleFoundation
import Core

public protocol FeatureBravoDependency: Dependency {
    var fooRepository: FooRepository { get }
}

class BravoFooBuilder: Builder<FeatureBravoDependency>, BravoFooBuildable {
    func build() -> UIViewController {
        BravoFooVC(
            dependency: .init(
                viewContainer: AnyViewContainer(BravoFooView()),
                fetchUseCase: fetchUseCase,
                updateUseCase: updateUseCase
            )
        )
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
