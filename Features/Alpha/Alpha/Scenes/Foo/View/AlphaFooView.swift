import Combine
import SwiftUI
import Core

protocol AlphaFooInput {
    var state: AlphaFooState { get set }
}

protocol AlphaFooOutput {
    var didTapBravoFoo: AnyPublisher<Void, Never> { get }
}

struct AlphaFooView: View, AlphaFooInput {
    private let didTapBravoFooSubject = PassthroughSubject<Void, Never>()

    @ObservedObject var state: AlphaFooState

    init(state: AlphaFooState) {
        self.state = state
    }

    var body: some View {
        VStack {
            if let fooValue = state.fooValue {
                Text("foo value:\(fooValue)")
            }
            Button(action: { didTapBravoFooSubject.send(()) }) {
                Text("Go to BravoFoo")
            }
            .frame(width: 200, height: 44)
        }
    }
}

extension AlphaFooView: AlphaFooOutput {
    var didTapBravoFoo: AnyPublisher<Void, Never> {
        didTapBravoFooSubject.eraseToAnyPublisher()
    }
}

extension AlphaFooView: ViewContainer {
    var input: AlphaFooInput { self }
    var output: AlphaFooOutput { self }
}
