import Testing
import UIKit
@testable import iOSAccessibilityUtils

struct AutomationCapableUIViewControllerTests {
    @Test
    @MainActor
    func test_setScreenIdentifiers_whenNothingIsSet_getAccessibilityIdentifier_mustBeNil() async throws {
        let viewController = AutomationCapableViewController()
        
        #expect(viewController.view.accessibilityIdentifier == nil)
    }
    
    @Test
    @MainActor
    func test_setScreenIdentifiers_whenIdentifierIsSet_identifierMustMatch() async throws {
        let viewController = AutomationCapableViewController()
        let expectedIdentifier = "expectedIdentifier"
        
        viewController.setScreenIdentifier(expectedIdentifier)
        
        #expect(expectedIdentifier == viewController.getScreenIdentifier() ?? "")
    }
}
