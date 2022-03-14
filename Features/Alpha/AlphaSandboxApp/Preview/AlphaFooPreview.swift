import SwiftUI
@testable import Alpha

struct AlphaFooPreview: PreviewProvider {
    static let devices = [
//        "iPhone 13 Pro Max",
        "iPhone SE (2nd generation)",
    ]
    
    static var previews: some View {
        Group {
            ForEach(devices, id: \.self) { name in
                AlphaFooView(state: .init(
                    fooValue: 1
                ))
                    .previewDevice(PreviewDevice(rawValue: name))
                    .previewDisplayName(name)
            }
        }
    }
}
