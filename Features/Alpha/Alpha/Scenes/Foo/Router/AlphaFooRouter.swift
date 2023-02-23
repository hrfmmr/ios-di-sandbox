import UIKit

import Dependencies

import Core

/// @mockable
struct AlphaFooRouter {
    var showBravoFoo: (_ vc: UIViewController) -> Void
}

extension AlphaFooRouter: DependencyKey {
    static var liveValue: Self {
        @Dependency(\.bravoSceneBuilder.buildFooScene) var buildFooScene
        
        return Self(
            showBravoFoo: { fromVC in
                let destVC = buildFooScene()
                fromVC.navigationController?.pushViewController(destVC, animated: true)
            }
        )
    }
}

extension DependencyValues {
    var alphaFooRouter: AlphaFooRouter {
        get { self[AlphaFooRouter.self] }
        set { self[AlphaFooRouter.self] = newValue }
    }
}
