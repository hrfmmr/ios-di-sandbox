import Foundation
import SwiftUI
import UIKit

public protocol ViewContainer {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
    var view: UIView { get }
}

public extension ViewContainer where Self: UIView {
    var view: UIView { self }
}

public extension ViewContainer where Self: View {
    var view: UIView { UIHostingController(rootView: self).view }
}

public class AnyViewContainer<Input, Output>: ViewContainer {
    public let input: Input
    public let output: Output
    public let view: UIView

    public init<T: ViewContainer>(_ container: T) where T.Input == Input, T.Output == Output {
        input = container.input
        output = container.output
        view = container.view
    }
}
