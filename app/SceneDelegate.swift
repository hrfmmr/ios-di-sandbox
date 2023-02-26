import UIKit

import Dependencies

import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    @Dependencies.Dependency(\.alphaSceneBuilder.buildFooScene) var buildAlphaFoo

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: scene)
            self.window = window
            let rootVC = buildAlphaFoo()
            window.rootViewController = UINavigationController(rootViewController: rootVC)
            window.makeKeyAndVisible()
        }
    }
}
