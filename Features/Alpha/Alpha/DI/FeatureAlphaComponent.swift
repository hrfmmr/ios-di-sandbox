import Combine
import Core
import Foundation
import NeedleFoundation
import UIKit

public protocol FeatureAlphaDependency: Dependency {
    var fooRepository: FooRepository { get }
    var bravoFooBuilder: BravoFooBuildable { get }
}

class AlphaFooBuilder: Builder<FeatureAlphaDependency>, AlphaFooBuildable {
    func build() -> UIViewController {
        let viewModel: AlphaFooViewModel = .init()
        return AlphaFooVC(
            dependency: .init(
                viewContainer: AnyViewContainer(makeViewContainer(viewModel: viewModel)),
                viewModel: viewModel,
                fetchUseCase: fetchUseCase,
                router: router
            )
        )
    }

    func makeViewContainer(viewModel: AlphaFooViewModel) -> AlphaFooView {
        AlphaFooView(viewModel: viewModel)
    }

    private var fetchUseCase: UseCase<Void, AnyPublisher<Int, Never>, Never> {
        UseCase(FetchFooValueUseCase(
            dependency: .init(
                gateway: dependency.fooRepository
            )
        ))
    }

    private var router: AlphaFooWireframe {
        AlphaFooRouter(dependency: .init(
            bravoFooBuilder: dependency.bravoFooBuilder
        ))
    }
}

public class FeatureAlphaComponent:
    Component<FeatureAlphaDependency>,
    FeatureAlpha
{
    public func fooBuilder() -> AlphaFooBuildable {
        AlphaFooBuilder(dependency: dependency)
    }
}
