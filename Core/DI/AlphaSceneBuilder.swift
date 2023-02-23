import Foundation
import UIKit
import XCTestDynamicOverlay

import Dependencies

public struct AlphaSceneBuilder {
    public var buildFooScene: () -> UIViewController
    
    public init(buildFooScene: @escaping () -> UIViewController) {
        self.buildFooScene = buildFooScene
    }
}

extension AlphaSceneBuilder: TestDependencyKey {
    public static let testValue: Self = Self(
        buildFooScene: unimplemented("\(Self.self).buildFooScene")
    )
}

public extension DependencyValues {
    var alphaSceneBuilder: AlphaSceneBuilder {
        get { self[AlphaSceneBuilder.self] }
        set { self[AlphaSceneBuilder.self] = newValue }
    }
}
