import Foundation
import UIKit

import Dependencies

import Core

extension BravoSceneBuilder: DependencyKey {
    public static let liveValue: Self = .init(
        buildFooScene: {
            let vc: UIViewController = .init()
            vc.view.backgroundColor = .white
            vc.title = "MockBravoFooVC"
            return vc
        }
    )
}
