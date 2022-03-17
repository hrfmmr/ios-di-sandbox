import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene,
           let rootComponent = (UIApplication.shared.delegate as? AppDelegate)?.rootComponent
        {
            let window = UIWindow(windowScene: scene)
            self.window = window
            let rootVC = rootComponent.alpha.fooBuilder().build()
            window.rootViewController = UINavigationController(rootViewController: rootVC)
            window.makeKeyAndVisible()
        }
    }
}
