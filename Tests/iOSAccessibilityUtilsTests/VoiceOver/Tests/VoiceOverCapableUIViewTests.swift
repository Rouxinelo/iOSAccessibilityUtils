import Testing
import UIKit
@testable import iOSAccessibilityUtils

struct VoiceOverCapableUIViewTests {
    @Test
    @MainActor
    func test_setVoiceOver() async throws {
        let view = VoiceOverCapableView()
        let expectedLabel = "expectedLabel"
        let expectedValue = "expectedValue"
        let expectedHint = "expectedHint"
        let expectedTrait: UIAccessibilityTraits = .header
        
        view.setVoiceOver(label: expectedLabel,
                          value: expectedValue,
                          hint: expectedHint,
                          trait: expectedTrait)
        
        #expect(view.accessibilityLabel == expectedLabel)
        #expect(view.accessibilityValue == expectedValue)
        #expect(view.accessibilityHint == expectedHint)
        #expect(view.accessibilityTraits == expectedTrait)
    }
    
    @Test
    @MainActor
    func test_isAccessibiltyElement_whenViewIsAccessible() async throws {
        let view = VoiceOverCapableView()
        view.setAsAccessibleElement(true)

        #expect(view.isAccessibilityElement)
    }
    
    @Test
    @MainActor
    func test_isAccessibiltyElement_whenViewIsNotAccessible() async throws {
        let view = VoiceOverCapableView()
        view.setAsAccessibleElement(false)

        #expect(!view.isAccessibilityElement)
    }
    
    @Test
    @MainActor
    func test_setAsAccessibilityContainer_then_elementsShouldNotBeAccessible() async throws {
        let view = VoiceOverCapableView()
        
        let firstElement = UIView()
        let secondElement = UIView()
        
        firstElement.isAccessibilityElement = true
        secondElement.isAccessibilityElement = true
        
        view.addSubview(firstElement)
        view.addSubview(secondElement)
        
        view.setAsAccessibilityContainer()
        
        #expect(view.isAccessibilityElement)
        #expect(view.accessibilityElements == nil)
        #expect(view.accessibilityElementsHidden)
    }
}
