import Foundation

import Dependencies

import Core

extension BravoSceneBuilder: DependencyKey {
    public static let liveValue: Self = .init(
        buildFooScene: {
            BravoFooVC()
        }
    )
}
