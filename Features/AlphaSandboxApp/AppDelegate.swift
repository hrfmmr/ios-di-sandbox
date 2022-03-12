import NeedleFoundation

#if DEBUG
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerProviderFactories()
        let _dependencyProviderRegistry = __DependencyProviderRegistry.instance
        print("\(_dependencyProviderRegistry)")
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootComponent = RootComponent()
        let alphaFooVC = rootComponent.featureAlphaComponent.fooBuilder().build()
//        alphaFooVC.view.backgroundColor = .white
//        alphaFooVC.title = "AlphaFooVC"
        window.rootViewController = UINavigationController(rootViewController: alphaFooVC)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
#endif
