import Testing
import UIKit
@testable import iOSAccessibilityUtils

struct SwitchControlCapableUIViewControllerTests {
    @Test
    @MainActor
    func test_setSwitchControlOrder_whenSetWithEmptyArray_thenAccessibilityElements_mustBeEmpty() async throws {
        let viewController = SwitchControlCapableViewController()
        viewController.setSwitchControlOrder([])
        
        #expect(viewController.view.accessibilityElements?.isEmpty ?? false)
    }
    
    @Test
    @MainActor
    func test_setSwitchControlOrder_whenSetWithArray_thenAccessibilityElements_mustContainElements() async throws {
        let viewController = SwitchControlCapableViewController()
        
        let viewsToAdd = [UIView(), UIView()]
        viewController.setSwitchControlOrder(viewsToAdd)
        
        #expect(viewsToAdd.count == viewController.view.accessibilityElements?.count ?? 0)
    }
}
