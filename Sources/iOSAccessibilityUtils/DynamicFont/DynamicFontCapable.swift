import UIKit

@MainActor
public protocol DynamicFontCapable {}

public extension DynamicFontCapable {
    func scaledFont(
        for style: UIFont.TextStyle = .body,
        weight: UIFont.Weight = .regular,
        maxPointSize: CGFloat? = nil
    ) -> UIFont {
        ScaledFontBuilder.systemFont(style: style, weight: weight, maxPointSize: maxPointSize)
    }

    func scaledCustomFont(
        _ font: UIFont,
        relativeTo style: UIFont.TextStyle = .body,
        maxPointSize: CGFloat? = nil
    ) -> UIFont {
        ScaledFontBuilder.customFont(font, relativeTo: style, maxPointSize: maxPointSize)
    }
}

public extension DynamicFontCapable where Self: UITraitEnvironment {
    var isAccessibilityCategory: Bool {
        traitCollection.preferredContentSizeCategory >= .accessibilityMedium
    }

    func isAboveSizeCategory(_ threshold: UIContentSizeCategory) -> Bool {
        traitCollection.preferredContentSizeCategory >= threshold
    }

    func onFontSize(
        standard: () -> Void,
        accessibility: () -> Void
    ) {
        isAccessibilityCategory ? accessibility() : standard()
    }

    func handleAccessibilityCategoryTransition(
        from previousTraitCollection: UITraitCollection?,
        didActivate: () -> Void,
        didDeactivate: () -> Void
    ) {
        guard let previous = previousTraitCollection else { return }
        let wasAccessibility = previous.preferredContentSizeCategory >= .accessibilityMedium
        let isNowAccessibility = traitCollection.preferredContentSizeCategory >= .accessibilityMedium

        switch (wasAccessibility, isNowAccessibility) {
        case (false, true): didActivate()
        case (true, false): didDeactivate()
        default: break
        }
    }

#if DEBUG
    var sizeCategoryDescription: String {
        switch traitCollection.preferredContentSizeCategory {
        case .extraSmall:                        return "XS"
        case .small:                             return "S"
        case .medium:                            return "M"
        case .large:                             return "L (default)"
        case .extraLarge:                        return "XL"
        case .extraExtraLarge:                   return "XXL"
        case .extraExtraExtraLarge:              return "XXXL"
        case .accessibilityMedium:               return "A-M"
        case .accessibilityLarge:                return "A-L"
        case .accessibilityExtraLarge:           return "A-XL"
        case .accessibilityExtraExtraLarge:      return "A-XXL"
        case .accessibilityExtraExtraExtraLarge: return "A-XXXL"
        default:                                 return "Unknown"
        }
    }
#endif
}

// MARK: - UIView
public extension DynamicFontCapable where Self: UIView {
    func onContentSizeCategoryChange(_ handler: @escaping (UIContentSizeCategory) -> Void) {
        if #available(iOS 17, *) {
            registerForTraitChanges([UITraitPreferredContentSizeCategory.self]) {
                (self: Self, _: UITraitCollection) in
                handler(self.traitCollection.preferredContentSizeCategory)
            }
        } else {
            NotificationCenter.default.addObserver(
                forName: UIContentSizeCategory.didChangeNotification,
                object: nil,
                queue: .main
            ) { _ in
                handler(UIApplication.shared.preferredContentSizeCategory)
            }
        }
    }
}

// MARK: - UIViewController
public extension DynamicFontCapable where Self: UIViewController {
    @discardableResult
    func observeContentSizeCategoryChanges(
        handler: @escaping (UIContentSizeCategory) -> Void
    ) -> NSObjectProtocol {
        NotificationCenter.default.addObserver(
            forName: UIContentSizeCategory.didChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            handler(UIApplication.shared.preferredContentSizeCategory)
        }
    }
}

// MARK: - UILabel
public extension UILabel {
    func setScaledFont(
        style: UIFont.TextStyle = .body,
        weight: UIFont.Weight = .regular,
        maxPointSize: CGFloat? = nil
    ) {
        font = ScaledFontBuilder.systemFont(style: style, weight: weight, maxPointSize: maxPointSize)
        adjustsFontForContentSizeCategory = true
    }

    func setScaledCustomFont(
        _ customFont: UIFont,
        relativeTo style: UIFont.TextStyle = .body,
        maxPointSize: CGFloat? = nil
    ) {
        font = ScaledFontBuilder.customFont(customFont, relativeTo: style, maxPointSize: maxPointSize)
        adjustsFontForContentSizeCategory = true
    }
}

// MARK: - UIButton
public extension UIButton {
    func setScaledFont(
        style: UIFont.TextStyle = .body,
        weight: UIFont.Weight = .regular,
        maxPointSize: CGFloat? = nil
    ) {
        titleLabel?.font = ScaledFontBuilder.systemFont(style: style, weight: weight, maxPointSize: maxPointSize)
        titleLabel?.adjustsFontForContentSizeCategory = true
    }

    func setScaledCustomFont(
        _ customFont: UIFont,
        relativeTo style: UIFont.TextStyle = .body,
        maxPointSize: CGFloat? = nil
    ) {
        titleLabel?.font = ScaledFontBuilder.customFont(customFont, relativeTo: style, maxPointSize: maxPointSize)
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
}

// MARK: - UITextField
public extension UITextField {
    func setScaledFont(
        style: UIFont.TextStyle = .body,
        weight: UIFont.Weight = .regular,
        maxPointSize: CGFloat? = nil
    ) {
        font = ScaledFontBuilder.systemFont(style: style, weight: weight, maxPointSize: maxPointSize)
        adjustsFontForContentSizeCategory = true
    }

    func setScaledCustomFont(
        _ customFont: UIFont,
        relativeTo style: UIFont.TextStyle = .body,
        maxPointSize: CGFloat? = nil
    ) {
        font = ScaledFontBuilder.customFont(customFont, relativeTo: style, maxPointSize: maxPointSize)
        adjustsFontForContentSizeCategory = true
    }
}

// MARK: - UITextView
public extension UITextView {

    func setScaledFont(
        style: UIFont.TextStyle = .body,
        weight: UIFont.Weight = .regular,
        maxPointSize: CGFloat? = nil
    ) {
        font = ScaledFontBuilder.systemFont(style: style, weight: weight, maxPointSize: maxPointSize)
        adjustsFontForContentSizeCategory = true
    }

    func setScaledCustomFont(
        _ customFont: UIFont,
        relativeTo style: UIFont.TextStyle = .body,
        maxPointSize: CGFloat? = nil
    ) {
        font = ScaledFontBuilder.customFont(customFont, relativeTo: style, maxPointSize: maxPointSize)
        adjustsFontForContentSizeCategory = true
    }
}

// MARK: - UIImageView
public extension UIImageView {
    func setScaledSymbol(
        named name: String,
        style: UIFont.TextStyle = .body,
        weight: UIImage.SymbolWeight = .regular
    ) {
        let config = UIImage.SymbolConfiguration(textStyle: style)
            .applying(UIImage.SymbolConfiguration(weight: weight))
        image = UIImage(systemName: name, withConfiguration: config)
        adjustsImageSizeForAccessibilityContentSizeCategory = true
    }
}
