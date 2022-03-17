import Combine
import SwiftUI

class BravoFooState: ObservableObject {
    @Published var fooValue: Int?

    init(fooValue: Int? = nil) {
        self.fooValue = fooValue
    }
}
