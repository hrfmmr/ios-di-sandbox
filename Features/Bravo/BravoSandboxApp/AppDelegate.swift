import NeedleFoundation

#if DEBUG
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerProviderFactories()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootComponent = RootComponent()
        let bravoFooVC = rootComponent.featureBravoComponent.fooBuilder().build()
        window.rootViewController = UINavigationController(rootViewController: bravoFooVC)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
#endif
