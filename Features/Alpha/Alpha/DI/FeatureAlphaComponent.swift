import Foundation
import NeedleFoundation
import Core
import UIKit

public protocol FeatureAlphaDependency: Dependency {
    var fooRepository: FooRepository { get }
}

class AlphaFooBuilder: Builder<FeatureAlphaDependency>, AlphaFooBuildable {
    func build() -> UIViewController {
        AlphaFooVC(
            dependency: .init(
                repository: dependency.fooRepository
            )
        )
    }
}

public class FeatureAlphaComponent:
    Component<FeatureAlphaDependency>,
    FeatureAlpha
{
    #if DEBUG
        override public init(parent: Scope) {
            let instance = __DependencyProviderRegistry.instance
            super.init(parent: parent)
        }
    #endif
    public func fooBuilder() -> AlphaFooBuildable {
        AlphaFooBuilder(dependency: dependency)
    }
}
