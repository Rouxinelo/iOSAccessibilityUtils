import Testing
import XCTest
import UIKit
@testable import iOSAccessibilityUtils

struct DynamicFontCapableUIViewTests {

    @Test
    @MainActor
    func test_isAccessibilityCategory_whenCategoryIsNotAccessibility_thenMustReturnFalse() async throws {
        let view = try await makeView(with: .extraSmall)
        #expect(!view.isAccessibilityCategory)
    }

    @Test
    @MainActor
    func test_isAccessibilityCategory_whenCategoryIsAccessibilityMedium_thenMustReturnTrue() async throws {
        let view = try await makeView(with: .accessibilityMedium)
        #expect(view.isAccessibilityCategory)
    }

    @Test
    @MainActor
    func test_isAccessibilityCategory_whenCategoryIsAccessibilityExtraLarge_thenMustReturnTrue() async throws {
        let view = try await makeView(with: .accessibilityExtraLarge)
        #expect(view.isAccessibilityCategory)
    }

    @Test
    @MainActor
    func test_isAboveSizeCategory_whenSizeIsBelowThreshold_thenMustReturnFalse() async throws {
        let view = try await makeView(with: .accessibilityMedium)
        #expect(!view.isAboveSizeCategory(.accessibilityLarge))
    }

    @Test
    @MainActor
    func test_isAboveSizeCategory_whenSizeIsEqualToThreshold_thenMustReturnFalse() async throws {
        let view = try await makeView(with: .accessibilityMedium)
        #expect(!view.isAboveSizeCategory(.accessibilityMedium))
    }

    @Test
    @MainActor
    func test_isAboveSizeCategory_whenSizeIsAboveThreshold_thenMustReturnTrue() async throws {
        let view = try await makeView(with: .accessibilityLarge)
        #expect(view.isAboveSizeCategory(.accessibilityMedium))
    }

    @Test
    @MainActor
    func test_onFontSize_whenStandardCategory_thenStandardClosure_mustBeCalled() async throws {
        let view = try await makeView(with: .large)
        var standardCalled = false

        view.onFontSize(
            standard: { standardCalled = true },
            accessibility: {}
        )

        #expect(standardCalled)
    }

    @Test
    @MainActor
    func test_onFontSize_whenAccessibilityCategory_thenAccessibilityClosure_mustBeCalled() async throws {
        let view = try await makeView(with: .accessibilityMedium)
        var accessibilityCalled = false

        view.onFontSize(
            standard: {},
            accessibility: { accessibilityCalled = true }
        )

        #expect(accessibilityCalled)
    }

    @Test
    @MainActor
    func test_handleTransition_whenCrossingIntoAccessibility_thenDidActivate_mustBeCalled() async throws {
        let view = try await makeView(with: .accessibilityMedium)
        let previous = UITraitCollection(preferredContentSizeCategory: .large)
        var activateCalled = false

        view.handleAccessibilityCategoryTransition(
            from: previous,
            didActivate: { activateCalled = true },
            didDeactivate: {}
        )

        #expect(activateCalled)
    }

    @Test
    @MainActor
    func test_handleTransition_whenCrossingOutOfAccessibility_thenDidDeactivate_mustBeCalled() async throws {
        let view = try await makeView(with: .large)
        let previous = UITraitCollection(preferredContentSizeCategory: .accessibilityMedium)
        var deactivateCalled = false

        view.handleAccessibilityCategoryTransition(
            from: previous,
            didActivate: {},
            didDeactivate: { deactivateCalled = true }
        )

        #expect(deactivateCalled)
    }
}

@MainActor
private func makeView(with category: UIContentSizeCategory) async throws -> DynamicFontCapableView {
    guard #available(iOS 17, *) else {
        throw XCTSkip("traitOverrides requires iOS 17+")
    }

    let vc = UIViewController()
    let window = UIWindow()
    let view = DynamicFontCapableView()
    vc.view.addSubview(view)
    window.rootViewController = vc
    window.makeKeyAndVisible()

    await Task.yield()

    view.traitOverrides.preferredContentSizeCategory = category

    await Task.yield()

    return view
}
