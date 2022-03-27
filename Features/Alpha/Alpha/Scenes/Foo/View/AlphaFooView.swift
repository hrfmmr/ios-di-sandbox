import Combine
import Core
import SwiftUI

struct AlphaFooView: View, AlphaFooInput {
    private let didTapBravoFooSubject = PassthroughSubject<Void, Never>()

    @ObservedObject var viewModel: AlphaFooViewModel

    init(viewModel: AlphaFooViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if let fooValue = viewModel.fooValue {
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
