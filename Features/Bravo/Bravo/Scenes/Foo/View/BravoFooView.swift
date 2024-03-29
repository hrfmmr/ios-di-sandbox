import Combine
import Core
import SwiftUI

struct BravoFooView: View, BravoFooInput {
    private let didTapIncrementFooSubject = PassthroughSubject<Void, Never>()

    @ObservedObject var state: BravoFooState

    init(state: BravoFooState) {
        self.state = state
    }

    var body: some View {
        VStack {
            if let fooValue = state.fooValue {
                Text("foo value:\(fooValue)")
            }
            Spacer()
                .frame(height: 40)
            Button(action: { didTapIncrementFooSubject.send(()) }) {
                Text("increment")
            }
        }
    }
}

extension BravoFooView: BravoFooOutput {
    var didTapIncrementFoo: AnyPublisher<Void, Never> {
        didTapIncrementFooSubject.eraseToAnyPublisher()
    }
}

extension BravoFooView: ViewContainer {
    var input: BravoFooInput { self }
    var output: BravoFooOutput { self }
}
