import NeedleFoundation
import UIKit

public protocol AlphaFooBuildable: Buildable {
    func build() -> UIViewController
}

public protocol FeatureAlpha {
    func fooBuilder() -> AlphaFooBuildable
}
