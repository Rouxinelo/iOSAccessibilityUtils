import UIKit

@MainActor
public protocol SwitchControlCapable {}

public extension SwitchControlCapable where Self: UIView {
    func setAsAccessibleElement(_ isAccessible: Bool) {
        self.isAccessibilityElement = isAccessible
    }
}

public extension SwitchControlCapable where Self: UIViewController {
    func setSwitchControlOrder(_ views: [UIView]) {
        view.accessibilityElements = views
    }
}
