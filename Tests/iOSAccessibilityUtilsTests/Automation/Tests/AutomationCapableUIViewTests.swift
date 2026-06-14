import Testing
import UIKit
@testable import iOSAccessibilityUtils

struct AutomationCapableUIViewTests {
    @Test
    @MainActor
    func test_setAccessibilityIdentifier_whenNothingIsSet_identifierMustBeNil() async throws {
        let view = AutomationCapableView()
        
        #expect(view.accessibilityIdentifier == nil)
    }
    
    @Test
    @MainActor
    func test_setAccessibilityIdentifier_whenIdentifierIsSet_withoutParent_identifierMustMatch() async throws {
        let view = AutomationCapableView()
        let expectedIdentifier = "expectedIdentifier"
        
        view.setAccessibilityIdentifier(expectedIdentifier)
        
        #expect(view.accessibilityIdentifier == expectedIdentifier)
    }
    
    @Test
    @MainActor
    func test_setAccessibilityIdentifier_whenIdentifierIsSet_withParent_identifierMustMatch() async throws {
        let view = AutomationCapableView()
        let parentIdentifier = "expectedParentIdentifier"
        let identifier = "expectedIdentifier"
        let expectedIdentifier = "\(parentIdentifier)_\(identifier)"
        
        view.setAccessibilityIdentifier(identifier, parentIdentifier: parentIdentifier)
        
        #expect(view.accessibilityIdentifier == expectedIdentifier)
    }
}
