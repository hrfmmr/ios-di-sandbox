import Foundation
import UIKit
import XCTestDynamicOverlay

import Dependencies

public struct BravoSceneBuilder {
    public var buildFooScene: () -> UIViewController

    public init(buildFooScene: @escaping () -> UIViewController) {
        self.buildFooScene = buildFooScene
    }
}

extension BravoSceneBuilder: TestDependencyKey {
    public static let testValue: Self = .init(
        buildFooScene: unimplemented("\(Self.self).buildFooScene")
    )
}

public extension DependencyValues {
    var bravoSceneBuilder: BravoSceneBuilder {
        get { self[BravoSceneBuilder.self] }
        set { self[BravoSceneBuilder.self] = newValue }
    }
}
