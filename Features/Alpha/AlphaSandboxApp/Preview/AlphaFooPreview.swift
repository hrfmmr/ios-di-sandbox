@testable import Alpha
import ComposableArchitecture
import SwiftUI

struct AlphaFooPreview: PreviewProvider {
    struct IntegratedVC: UIViewControllerRepresentable {
        init() {
            registerProviderFactories()
        }

        func makeUIViewController(context _: Context) -> some UIViewController {
            let vc = RootComponent().featureAlphaComponent.fooBuilder().build()
            return UINavigationController(rootViewController: vc)
        }

        func updateUIViewController(_: UIViewControllerType, context _: Context) {}
    }

    struct Wrapper: View {
        var body: some View {
            IntegratedVC()
        }
    }

    static let devices = [
        "iPhone 13 Pro Max",
        "iPhone SE (2nd generation)",
    ]

    static var previews: some View {
        Group {
            ForEach(devices, id: \.self) { name in
                Wrapper()
                    .previewDevice(PreviewDevice(rawValue: name))
                    .previewDisplayName(name)
            }
        }
    }
}
