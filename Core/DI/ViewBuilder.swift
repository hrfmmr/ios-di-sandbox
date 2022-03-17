import Foundation
import NeedleFoundation

public protocol Buildable: AnyObject {}

open class Builder<Dependency>: Buildable {
    public let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }
}
