import UIKit

@MainActor
public protocol VoiceOverCapable {
    var isVoiceOverRunning: Bool { get }
    func announce(_ text: String)
}

public extension VoiceOverCapable {
    var isVoiceOverRunning: Bool {
        UIAccessibility.isVoiceOverRunning
    }
    
    func announce(_ message: String) {
        UIAccessibility.post(notification: .announcement,
                             argument: message)
    }
}

public extension VoiceOverCapable where Self: UIView {
    func setVoiceOver(label: String? = nil,
                      value: String? = nil,
                      hint: String? = nil,
                      trait: UIAccessibilityTraits = .staticText) {
        self.accessibilityLabel = label
        self.accessibilityValue = value
        self.accessibilityHint = hint
        self.accessibilityTraits = trait
    }
    
    func setAsAccessibleElement(_ isAccessible: Bool) {
        self.isAccessibilityElement = isAccessible
    }
    
    func setAsAccessibilityContainer() {
        accessibilityElements = nil
        accessibilityElementsHidden = true
        setAsAccessibleElement(true)
    }
    
    func focus(notification: UIAccessibility.Notification = .layoutChanged,
               after delay: TimeInterval = 0.0) {
        guard self.isVoiceOverRunning else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIAccessibility.post(notification: notification, argument: self)
        }
    }
}

public extension VoiceOverCapable where Self: UIViewController {
    var headerView: UIView? {
        navigationItem.titleView
    }
    
    func setTitleView(with view: UIView) {
        navigationItem.titleView = view
    }
    
    func setTitleViewAccessibility(label: String) {
        guard let headerView else { return }
        headerView.isAccessibilityElement = true
        headerView.accessibilityLabel = label
        headerView.accessibilityTraits = .header
    }
    
    func focusOnHeader(after delay: TimeInterval = 0.0) {
        guard let headerView, isVoiceOverRunning else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIAccessibility.post(notification: .screenChanged, argument: headerView)
        }
    }
}
