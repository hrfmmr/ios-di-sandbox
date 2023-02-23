import Foundation

import Dependencies

import Core

extension AlphaSceneBuilder: DependencyKey {
    public static let liveValue: Self = Self(
        buildFooScene: {
            AlphaFooVC()
        }
    )
}
