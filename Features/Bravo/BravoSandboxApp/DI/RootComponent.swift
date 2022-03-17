import Bravo
import Core
import Foundation
import NeedleFoundation
import UIKit

class RootComponent: BootstrapComponent {
    var featureBravoComponent: FeatureBravoComponent {
        FeatureBravoComponent(parent: self)
    }

    var fooRepository: FooRepository {
        shared { FooRepositoryImpl() }
    }
}
