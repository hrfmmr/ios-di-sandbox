import UIKit

public protocol BravoFooBuildable: Buildable {
    func build() -> UIViewController
}

public protocol FeatureBravo {
    func fooBuilder() -> BravoFooBuildable
}
