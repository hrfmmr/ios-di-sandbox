import NeedleFoundation

#if DEBUG
    import UIKit

    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?

        func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            registerProviderFactories()
            let window = UIWindow(frame: UIScreen.main.bounds)
            let rootComponent = RootComponent()
            let alphaFooVC = rootComponent.featureAlphaComponent.fooBuilder().build()
            window.rootViewController = UINavigationController(rootViewController: alphaFooVC)
            window.makeKeyAndVisible()
            self.window = window
            return true
        }
    }
#endif
