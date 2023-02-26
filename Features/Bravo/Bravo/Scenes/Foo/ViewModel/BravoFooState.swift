import Combine
import SwiftUI

import Dependencies

@MainActor
class BravoFooState: ObservableObject {
    @Published var fooValue: Int?

    init(fooValue: Int? = nil) {
        self.fooValue = fooValue
    }
}

extension BravoFooState: DependencyKey {
    static let liveValue: BravoFooState = .init()
}

extension DependencyValues {
    var fooState: BravoFooState {
        get { self[BravoFooState.self] }
        set { self[BravoFooState.self] = newValue }
    }
}
