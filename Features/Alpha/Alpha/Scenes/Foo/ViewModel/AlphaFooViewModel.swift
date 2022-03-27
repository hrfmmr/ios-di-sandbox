import Combine
import SwiftUI

class AlphaFooViewModel: ObservableObject {
    @Published var fooValue: Int?

    init(fooValue: Int? = nil) {
        self.fooValue = fooValue
    }
}
