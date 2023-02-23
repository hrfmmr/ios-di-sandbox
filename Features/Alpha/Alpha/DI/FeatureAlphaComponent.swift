import Combine
import Foundation
import UIKit

import NeedleFoundation

import Core

public protocol FeatureAlphaDependency: NeedleFoundation.Dependency {
    var fooRepository: FooRepository { get }
    var bravoFooBuilder: BravoFooBuildable { get }
}

class AlphaFooBuilder: Builder<FeatureAlphaDependency>, AlphaFooBuildable {
    func build() -> UIViewController {
        AlphaFooVC()
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
