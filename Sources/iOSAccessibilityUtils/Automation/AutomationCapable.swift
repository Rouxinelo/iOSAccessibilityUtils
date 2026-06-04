import UIKit

@MainActor
public protocol AutomationCapable {}

public extension AutomationCapable where Self: UIView {
    func setAccessibilityIdentifier(_ identifier: String,
                                    parentIdentifier: String? = nil) {
        if let parentIdentifier {
            accessibilityIdentifier = "\(parentIdentifier)_\(identifier)"
        } else {
            accessibilityIdentifier = identifier
        }
    }
}

public extension AutomationCapable where Self: UIViewController {
    func setScreenIdentifier(_ identifier: String) {
        view.accessibilityIdentifier = identifier
    }
}
