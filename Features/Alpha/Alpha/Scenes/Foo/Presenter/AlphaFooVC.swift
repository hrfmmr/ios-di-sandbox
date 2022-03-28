import Combine
import ComposableArchitecture
import Core
import SwiftUI
import UIKit

final class AlphaFooVC: UIViewController {
    // MARK: Types

    typealias State = AlphaFooState
    typealias Action = AlphaFooAction

    // DI
    public struct Dependency {
        let store: Store<State, Action>
    }

    // MARK: Props

    private let dependency: Dependency
    private let viewStore: ViewStore<State, Action>
    private var store: Store<State, Action> { dependency.store }

    // MARK: Init

    public init(dependency: Dependency) {
        self.dependency = dependency
        viewStore = .init(dependency.store)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override public func viewDidLoad() {
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
