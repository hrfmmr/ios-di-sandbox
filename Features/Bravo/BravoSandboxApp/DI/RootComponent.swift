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
        shared { FooRepositoryImpl() }
    }
}
