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
    @Test("Testing percentage value")
    func testingPercentageValue() async throws {
        let price = SearchItemPrice(amount: 5499, originalAmount: 6799, currency: "", formatedAmount: "", installments: nil)
        #expect(price.discountPercentage == 19)
    }

    @Test("Testing empty original amount")
    func testingEmptyOriginalAmount() async throws {
        let price = SearchItemPrice(amount: 5499, originalAmount: nil, currency: "", formatedAmount: "", installments: nil)
        #expect(price.discountPercentage == nil)
    }

    @Test("Testing zero original amount")
    func testingZeroOriginalAmount() async throws {
        let price = SearchItemPrice(amount: 5499, originalAmount: 0, currency: "", formatedAmount: "", installments: nil)
        #expect(price.discountPercentage == nil)
    }
}
