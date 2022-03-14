import Combine
import SwiftUI
import Core

protocol BravoFooInput {
    func update(_ state: BravoFooViewState)
}

protocol BravoFooOutput {
    var didTapIncrementFoo: AnyPublisher<Void, Never> { get }
}

class BravoFooViewState: ObservableObject {
    @Published var fooValue: Int?
    
    init(fooValue: Int? = nil) {
        self.fooValue = fooValue
    }
}

struct BravoFooView: View {
    private let didTapIncrementFooSubject = PassthroughSubject<Void, Never>()
    
    @ObservedObject private var state: BravoFooViewState

    init(state: BravoFooViewState = .init()) {
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

extension BravoFooView: BravoFooInput {
    func update(_ state: BravoFooViewState) {
        self.state.fooValue = state.fooValue
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
