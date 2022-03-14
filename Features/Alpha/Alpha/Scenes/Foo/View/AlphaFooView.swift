import Combine
import SwiftUI
import Core

protocol AlphaFooInput {
    func update(_ state: AlphaFooViewState)
}

protocol AlphaFooOutput {
    var didTapBravoFoo: AnyPublisher<Void, Never> { get }
}

class AlphaFooViewState: ObservableObject {
    @Published var fooValue: Int?
    
    init(fooValue: Int? = nil) {
        self.fooValue = fooValue
    }
}

struct AlphaFooView: View {
    private let didTapBravoFooSubject = PassthroughSubject<Void, Never>()

    @ObservedObject private var state: AlphaFooViewState = .init()

    init(state: AlphaFooViewState = .init()) {
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

extension AlphaFooView: AlphaFooInput {
    func update(_ state: AlphaFooViewState) {
        self.state.fooValue = state.fooValue
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
