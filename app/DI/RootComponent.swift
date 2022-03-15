import NeedleFoundation
import Core
import Alpha
import Bravo

class RootComponent: BootstrapComponent {
    var alpha: FeatureAlphaComponent {
        FeatureAlphaComponent(parent: self)
    }
    
    var bravo: FeatureBravoComponent {
        FeatureBravoComponent(parent: self)
    }

    var fooRepository: FooRepository {
        shared { FooRepositoryImpl() }
    }

    var bravoFooBuilder: BravoFooBuildable {
        bravo.fooBuilder()
    }
}
