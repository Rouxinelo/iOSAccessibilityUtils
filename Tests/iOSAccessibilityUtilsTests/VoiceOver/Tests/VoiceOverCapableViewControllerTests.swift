import Testing
@testable import iOSAccessibilityUtils

struct VoiceOverCapableViewControllerTests {
    @Test
    @MainActor
    func test_setTitleView() async throws {
        let viewController = VoiceOverCapableViewController()
        let headerView = VoiceOverCapableView()
        
        viewController.setTitleView(with: headerView)
        
        #expect(viewController.headerView === headerView)
    }
    
    @Test
    @MainActor
    func test_getTitleView_whenNoneIsSet() async throws {
        let viewController = VoiceOverCapableViewController()
        
        #expect(viewController.headerView == nil)
    }
    
    @Test
    @MainActor
    func test_setTitleView_withAccessibility() async throws {
        let viewController = VoiceOverCapableViewController()
        let accessibilityLabel = "exampleLabel"
        
        viewController.setTitleView(with: VoiceOverCapableView())
        viewController.setTitleViewAccessibility(label: accessibilityLabel)
        
        let headerView = viewController.headerView
        
        #expect(headerView?.accessibilityLabel == accessibilityLabel)
        #expect(headerView?.accessibilityTraits == .header)
        #expect(headerView?.isAccessibilityElement ?? false)
    }
    
    @Test
    @MainActor
    func test_setTitleView_withoutAccessibility() async throws {
        let viewController = VoiceOverCapableViewController()
        let headerView = VoiceOverCapableView()
        
        headerView.isAccessibilityElement = false
        viewController.setTitleView(with: headerView)
        
        #expect(!(viewController.headerView?.isAccessibilityElement ?? true))
    }
}
