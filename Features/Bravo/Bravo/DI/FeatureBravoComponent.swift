import Foundation
import NeedleFoundation
import Core
import UIKit

public protocol FeatureBravoDependency: Dependency {
    var fooRepository: FooRepository { get }
}

class BravoFooBuilder: Builder<FeatureBravoDependency>, BravoFooBuildable {
    func build() -> UIViewController {
        BravoFooVC(
            dependency: .init(
                repository: dependency.fooRepository
            )
        )
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
