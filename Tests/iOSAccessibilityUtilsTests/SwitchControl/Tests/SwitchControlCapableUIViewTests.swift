import Testing
import UIKit
@testable import iOSAccessibilityUtils

struct SwitchControlCapableUIViewTests {
    @Test
    @MainActor
    func test_setAsAccessibleElement_whenSetAsTrue_thenElementShouldBeAccessible() async throws {
        let view = SwitchControlCapableView()
        view.setAsAccessibleElement(true)
        
        #expect(view.isAccessibilityElement)
    }
    
    @Test
    @MainActor
    func test_setAsAccessibleElement_whenSetAsFalse_thenElementShouldNotBeAccessible() async throws {
        let view = SwitchControlCapableView()
        view.setAsAccessibleElement(false)
        
        #expect(!view.isAccessibilityElement)
    }
}
