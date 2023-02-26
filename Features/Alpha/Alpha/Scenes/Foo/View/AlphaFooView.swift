import ComposableArchitecture
import SwiftUI
import UIKit

struct AlphaFooView: View {
    // MARK: Props

    private let store: StoreOf<AlphaFooReducer>
    private let vc: UIViewController

    init(store: StoreOf<AlphaFooReducer>, vc: UIViewController) {
        self.store = store
        self.vc = vc
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                if let fooValue = viewStore.fooValue {
                    Text("foo value:\(fooValue)")
                }
                Button(action: { viewStore.send(.showBravoButtonTapped(vc)) }) {
                    Text("Go to BravoFoo")
                }
                .frame(width: 200, height: 44)
            }
        }
    }
}

extension AlphaFooView {
    var uiview: UIView { UIHostingController(rootView: self).view }
}
