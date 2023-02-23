import Dependencies

#if DEBUG
    import UIKit

    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?
        @Dependencies.Dependency(\.alphaSceneBuilder.buildFooScene) var buildAlphaFooScene

        func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let alphaFooVC = buildAlphaFooScene()
            window.rootViewController = UINavigationController(rootViewController: alphaFooVC)
            window.makeKeyAndVisible()
            self.window = window
            return true
        }
    }
#endif
