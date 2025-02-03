//
//  InjectedTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 02/02/25.
//

import Testing
@testable import Challenge_Mercado_Libre

@Suite("Testing @Inject", .serialized)
struct InjectTests {

    @Test("Testing default value")
    func testingDefaultValue() async throws {
        @Injected(\.networkProvider) var networkProvider

        #expect(networkProvider is NetworkManager)
    }

    @Test("Testing mocked network")
    func testingSettingMockedNetwork() async throws {
        @Injected(\.networkProvider) var networkProvider

        #expect(networkProvider is NetworkManager)
        networkProvider = NetworkManagerMock()
        #expect(networkProvider is NetworkManagerMock)
    }
}
