import Foundation
import NeedleFoundation
import Bravo
import Core
import UIKit

class RootComponent: BootstrapComponent {
    var featureBravoComponent: FeatureBravoComponent {
        FeatureBravoComponent(parent: self)
    }

    var fooRepository: FooRepository {
        FooRepositoryImpl()
    }

    override init() {
        let instance = __DependencyProviderRegistry.instance
        super.init()
    }
}

// MARK: Feature Bravo dependency
extension RootComponent {
}

// MARK: Feature other dependencies
extension RootComponent {
}
