import Foundation
import Combine
import UIKit
import Core
import NeedleFoundation

public protocol FeatureAlphaDependency: Dependency {
    var fooRepository: FooRepository { get }
    var bravoFooBuilder: BravoFooBuildable { get }
}

class AlphaFooBuilder: Builder<FeatureAlphaDependency>, AlphaFooBuildable {
    func build() -> UIViewController {
        let state: AlphaFooState = .init()
        return AlphaFooVC(
            dependency: .init(
                viewContainer: AnyViewContainer(makeViewContainer(state: state)),
                state: state,
                fetchUseCase: fetchUseCase,
                router: router
            )
        )
    }
    
    func makeViewContainer(state: AlphaFooState) -> AlphaFooView {
        AlphaFooView(state: state)
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
