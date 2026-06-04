import UIKit
import iOSAccessibilityUtils

// MARK: - View Controller
class AutomationCapableViewController: UIViewController {}

extension AutomationCapableViewController: AutomationCapable {}

// MARK: - UIView

class AutomationCapableView: UIView {}

extension AutomationCapableView: AutomationCapable {}
