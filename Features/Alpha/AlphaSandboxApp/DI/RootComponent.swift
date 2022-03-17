import Alpha
import Core
import Foundation
import NeedleFoundation
import UIKit

class RootComponent: BootstrapComponent {
    var featureAlphaComponent: FeatureAlphaComponent {
        FeatureAlphaComponent(parent: self)
    }

    var fooRepository: FooRepository {
        shared { FooRepositoryImpl() }
    }

    var bravoFooBuilder: BravoFooBuildable {
        MockBravoFooBuilder()
    }
}

private extension RootComponent {
    class MockBravoFooBuilder: BravoFooBuildable {
        func build() -> UIViewController {
            let vc: UIViewController = .init()
            vc.view.backgroundColor = .white
            vc.title = "MockBravoFooVC"
            return vc
        }
    }
}
