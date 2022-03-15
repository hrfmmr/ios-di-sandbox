import UIKit
import NeedleFoundation
import AlphaSandboxApp

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private(set) var rootComponent: RootComponent!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerProviderFactories()
        rootComponent = RootComponent()
        return true
    }
}
