import NeedleFoundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private(set) var rootComponent: RootComponent!

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerProviderFactories()
        rootComponent = RootComponent()
        return true
    }
}
