//
//  SearchServiceTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation
import Testing
import Mocker
@testable import Challenge_Mercado_Libre

@Suite("Search Service Tests")
struct SearchServiceTests {
    let service: SearchService

    init() {
        let session = MockSession.createMockSession()
        self.service = SearchService(session: session)
    }

    @Test("Testing Search Response")
    func testingSearchResponse() async throws {
        let originalURL = URL(string: "/search")!
        let mock = Mock(url: originalURL, ignoreQuery: true, contentType: .json, statusCode: 200, data: [
            .get: try! Data(contentsOf: MockedData.searchService)
        ])

        mock.register()

        let request = await self.service.query("Apple Watch", category: nil, limit: 10, offset: 0)

        switch request.result {
        case .success(let response):
            #expect(response.siteId == "MLB")
            #expect(response.paging.primaryResults == 1000)
            #expect(response.paging.offset == 0)
            #expect(response.paging.limit == 10)
            #expect(response.paging.total == 1265)
        case .failure(let error):
            Issue.record(error)
        }
    }
}
