import Combine
import ComposableArchitecture
import Core
import SwiftUI
import UIKit

final class AlphaFooVC: UIViewController {
    // MARK: Props
    private let store: StoreOf<AlphaFooReducer>
    private let viewStore: ViewStoreOf<AlphaFooReducer>

    // MARK: Init
    init() {
        let store: StoreOf<AlphaFooReducer> = .init(
            initialState: AlphaFooReducer.State(),
            reducer: AlphaFooReducer()
        )
        self.store = store
        self.viewStore = .init(store)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(describing: type(of: self))
        configureNavBar()
        configureView()
        viewStore.send(.onAppear)
    }

    // MARK: Set up

    private func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureView() {
        let contentVC = UIHostingController(
            rootView: AlphaFooView(
                store: store,
                vc: self
            )
        )
        _ = {
            addChild($0)
            view.addSubview($0.view)
            $0.didMove(toParent: self)
            $0.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.view.topAnchor.constraint(equalTo: view.topAnchor),
                $0.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }(contentVC)
    }
}
