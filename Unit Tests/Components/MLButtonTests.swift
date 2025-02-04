//
//  MLButtonTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 03/02/25.
//

import Testing
import UIKit
@testable import Challenge_Mercado_Libre

@Suite("Mercado Libre button tests")
@MainActor
struct MLButtonTests {
    var button: MLButton

    init() {
        self.button = MLButton(configuration: .mercadoLibre())
    }

    @Test("Testing button state normal")
    func testingButtonStateNormal() async throws {
        button.isSelected = false
        button.isHighlighted = false
        button.isEnabled = true
        button.updateConfiguration()

        let configuration = button.configuration
        let backgroundColor = configuration?.background.backgroundColor
        let foregroundColor = configuration?.baseForegroundColor

        #expect(backgroundColor == UIColor.mlBlue)
        #expect(foregroundColor == UIColor.tintColor)
    }

    @Test("Testing button state hightlighted")
    func testingButtonStateHightlighted() async throws {
        button.isSelected = false
        button.isHighlighted = true
        button.isEnabled = true
        button.updateConfiguration()

        let configuration = button.configuration
        let backgroundColor = configuration?.background.backgroundColor
        let foregroundColor = configuration?.baseForegroundColor

        #expect(backgroundColor == UIColor.mlBlue.withAlphaComponent(0.3))
        #expect(foregroundColor == UIColor.tintColor)
    }

    @Test("Testing button state selected")
    func testingButtonStateSelected() async throws {
        button.isSelected = true
        button.isHighlighted = false
        button.isEnabled = true
        button.updateConfiguration()

        let configuration = button.configuration
        let backgroundColor = configuration?.background.backgroundColor
        let foregroundColor = configuration?.baseForegroundColor

        #expect(backgroundColor == UIColor.tintColor)
        #expect(foregroundColor == UIColor.white)
    }

    @Test("Testing button state disabled")
    func testingButtonStateDisabled() async throws {
        button.isSelected = false
        button.isHighlighted = false
        button.isEnabled = false
        button.updateConfiguration()

        let configuration = button.configuration
        let backgroundColor = configuration?.background.backgroundColor
        let foregroundColor = configuration?.baseForegroundColor

        #expect(backgroundColor == UIColor.mlBlue.withAlphaComponent(0.3))
        #expect(foregroundColor == UIColor.white)
    }

    @Test("Testing button state selected and highlighted")
    func testingButtonStateSelectedAndHighlighted() async throws {
        button.isSelected = true
        button.isHighlighted = true
        button.isEnabled = true
        button.updateConfiguration()

        let configuration = button.configuration
        let backgroundColor = configuration?.background.backgroundColor
        let foregroundColor = configuration?.baseForegroundColor

        #expect(backgroundColor == UIColor.mlBlue.withAlphaComponent(0.3))
        #expect(foregroundColor == UIColor.white)
    }
}
