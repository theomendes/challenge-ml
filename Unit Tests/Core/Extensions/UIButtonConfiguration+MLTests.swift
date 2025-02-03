//
//  UIButtonConfiguration+MLTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 02/02/25.
//

import Testing
import UIKit
@testable import Challenge_Mercado_Libre

@Suite("UIButtonConfiguration with Mercado Libre tests")
struct UIButtonConfiguration_MLTests {

    @Test("Testing Mercado Libre Button Configuration")
    func testingButtonConfigurationValues() async throws {
        let configuration = UIButton.Configuration.mercadoLibre()

        #expect(configuration.background.cornerRadius == 3)
    }

}
