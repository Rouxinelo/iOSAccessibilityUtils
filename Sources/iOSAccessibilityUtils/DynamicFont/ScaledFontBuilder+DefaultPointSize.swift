import UIKit

extension UIFont.TextStyle {
    var defaultPointSize: CGFloat {
        switch self {
        case .largeTitle:  return 34
        case .title1:      return 28
        case .title2:      return 22
        case .title3:      return 20
        case .headline:    return 17
        case .body:        return 17
        case .callout:     return 16
        case .subheadline: return 15
        case .footnote:    return 13
        case .caption1:    return 12
        case .caption2:    return 11
        default:           return 17
        }
    }
}

enum ScaledFontBuilder {
    static func build(
        base: UIFont,
        style: UIFont.TextStyle,
        maxPointSize: CGFloat?
    ) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        if let max = maxPointSize {
            return metrics.scaledFont(for: base, maximumPointSize: max)
        }
        return metrics.scaledFont(for: base)
    }

    static func systemFont(
        style: UIFont.TextStyle,
        weight: UIFont.Weight,
        maxPointSize: CGFloat?
    ) -> UIFont {
        let base = UIFont.systemFont(ofSize: style.defaultPointSize, weight: weight)
        return build(base: base, style: style, maxPointSize: maxPointSize)
    }

    static func customFont(
        _ font: UIFont,
        relativeTo style: UIFont.TextStyle,
        maxPointSize: CGFloat?
    ) -> UIFont {
        build(base: font, style: style, maxPointSize: maxPointSize)
    }
}
