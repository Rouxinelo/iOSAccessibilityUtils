import UIKit

@MainActor
public protocol SwitchControlCapable {}

public extension SwitchControlCapable where Self: UIView {
    func setAsAccessibleElement(_ isAccessible: Bool) {
        self.isAccessibilityElement = isAccessible
    }
}

public extension SwitchControlCapable where Self: UIViewController {
    func configureScanningOrder(_ views: [UIView]) {
        view.accessibilityElements = views
    }
}
