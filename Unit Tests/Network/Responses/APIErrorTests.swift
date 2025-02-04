//
//  APIErrorTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 02/02/25.
//

import Foundation
import Testing
@testable import Challenge_Mercado_Libre

@Suite("API Error Tests")
struct APIErrorTests {

    @Test("Testing decoding API Error")
    func testingDecodeAPIError() async throws {
        let data = try Data(contentsOf: MockedData.custom403Error)
        let decoded = try JSONDecoder().decode(APIError.self, from: data)

        #expect(decoded.code == "PA_UNAUTHORIZED_RESULT_FROM_POLICIES")
        #expect(decoded.message == "At least one policy returned UNAUTHORIZED.")
        #expect(decoded.status == 403)
        #expect(decoded.blockedBy == "PolicyAgent")
    }

}
