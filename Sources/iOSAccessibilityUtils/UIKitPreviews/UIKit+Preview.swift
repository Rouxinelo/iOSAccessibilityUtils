#if DEBUG
import SwiftUI

enum PreviewPosition {
    case top
    case center
    case bottom
}

enum PreviewSize: Equatable {
    case full
    case fixed(CGFloat)
    case flexible
    
    var fixedValue: CGFloat? {
        if case .fixed(let v) = self { return v }
        return nil
    }
}

extension UIView {
    func fullScreenPreview(padding: EdgeInsets = .init()) -> some View {
        Preview(view: self)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(padding)
    }

    func preview(
        position: VerticalAlignment = .center,
        width: PreviewSize = .flexible,
        height: PreviewSize = .flexible
    ) -> some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: position)) {
            Color.clear
            Preview(view: self)
                .modifier(PreviewSizeModifier(width: width, height: height))
        }
    }

    private struct Preview: UIViewRepresentable {
        let view: UIView
        func makeUIView(context: Context) -> UIView { view }
        func updateUIView(_ uiView: UIView, context: Context) {}
    }

    private struct PreviewSizeModifier: ViewModifier {
        let width: PreviewSize
        let height: PreviewSize

        func body(content: Content) -> some View {
            content
                .frame(
                    width: width.fixedValue,
                    height: height.fixedValue
                )
                .frame(
                    maxWidth:  width  == .full ? .infinity : nil,
                    maxHeight: height == .full ? .infinity : nil
                )
        }
    }
}
#endif
