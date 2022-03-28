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
        return AlphaFooVC(
            dependency: .init(
                store: .init(
                    initialState: .init(),
                    reducer: alphaFooReducer,
                    environment: environment
                )
            )
        )
    }

    var environment: AlphaFooEnvironment {
        .init(
            repository: dependency.fooRepository,
            router: router,
            mainQueue: .main
        )
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
