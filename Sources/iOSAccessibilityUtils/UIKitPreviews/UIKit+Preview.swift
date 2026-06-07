#if DEBUG
import SwiftUI

extension UIView {
    func preview() -> some View {
        Preview(view: self)
    }

    private struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> UIView { view }
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
}
#endif
