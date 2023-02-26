#if DEBUG
    import UIKit

    import Dependencies

    import Core

    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?
        @Dependencies.Dependency(\.bravoSceneBuilder.buildFooScene) var buildFooScene

        func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let bravoFooVC = buildFooScene()
            window.rootViewController = UINavigationController(rootViewController: bravoFooVC)
            window.makeKeyAndVisible()
            self.window = window
            return true
        }
    }
#endif
