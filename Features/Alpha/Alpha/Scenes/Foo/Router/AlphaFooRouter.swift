import Core
import UIKit

protocol AlphaFooWireframe {
    func showBravoFoo(on viewController: UIViewController)
}

class AlphaFooRouter: AlphaFooWireframe {
    struct Dependency {
        let bravoFooBuilder: BravoFooBuildable
    }

    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func showBravoFoo(on viewController: UIViewController) {
        let vc = dependency.bravoFooBuilder.build()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
