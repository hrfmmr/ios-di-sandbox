import Combine
import SwiftUI

class AlphaFooState: ObservableObject {
    @Published var fooValue: Int?
    
    init(fooValue: Int? = nil) {
        self.fooValue = fooValue
    }
}
