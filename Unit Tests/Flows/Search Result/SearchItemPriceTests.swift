//
//  SearchItemPriceTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 03/02/25.
//

import Testing
@testable import Challenge_Mercado_Libre

@Suite("Search Item Price Tests")
struct SearchItemPriceTests {
    @Test("Testinge percentage value")
    func testingPercentageValue() async throws {
        let price = SearchItemPrice(amount: 5499, originalAmount: 6799, currency: "", formatedAmount: "", installments: nil)
        #expect(price.discountPercentage == 19)
    }
}
