import Foundation
import NeedleFoundation
import Alpha
import Core
import UIKit

class RootComponent: BootstrapComponent {
    var featureAlphaComponent: FeatureAlphaComponent {
        FeatureAlphaComponent(parent: self)
    }

    var fooRepository: FooRepository {
        FooRepositoryImpl()
    }

    override init() {
        let instance = __DependencyProviderRegistry.instance
        super.init()
    }
}

// MARK: Feature Alpha dependency
extension RootComponent {
}

// MARK: Feature other dependencies
extension RootComponent {
}

// MARK: - Debug

//public protocol FeatureAlphaDependency: Dependency {
//    var fooRepository: FooRepository { get }
//}
//
//class AlphaFooBuilder: Builder<FeatureAlphaDependency>, AlphaFooBuildable {
//    func build() -> UIViewController {
//        .init(nibName: nil, bundle: nil)
//    }
//}
//
//public class FeatureAlphaComponent:
//    Component<FeatureAlphaDependency>,
//    FeatureAlpha
//{
//    public func fooBuilder() -> AlphaFooBuildable {
//        AlphaFooBuilder(dependency: dependency)
//    }
//
//    override public init(parent: Scope) {
//        let instance = __DependencyProviderRegistry.instance
//        super.init(parent: parent)
//    }
//}
