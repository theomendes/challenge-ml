//
//  SearchResultVMTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation
import Testing
import Mocker
@testable import Challenge_Mercado_Libre

@Suite("Search Result VM Tests")
struct SearchResultVMTests {
    let viewModel: SearchResultVM

    init() {
        let searchService = SearchService(session: MockSession.createMockSession())
        let searchUseCase = SearchUseCase(repository: SearchResultRepository(service: searchService))
        self.viewModel = SearchResultVM(useCase: searchUseCase, query: .init(text: "Apple Watch", siteID: "MLB"))
    }

    @Test("Testing default values")
    func testingDefaultValues() async throws {
        #expect(viewModel.query.text == "Apple Watch")
        #expect(viewModel.query.siteID == "MLB")
        #expect(viewModel.sections.isEmpty)
        #expect(viewModel.limit == 20)
        #expect(viewModel.offSet == 0)
        #expect(!viewModel.isLoading)
    }

    @Test("Testing fetch results")
    func testingFetchResults() async throws {
        let url = URL(string: "/search")!
        let resultData = try Data(contentsOf: MockedData.searchService)
        let mock = Mock(url: url, ignoreQuery: true, contentType: .json, statusCode: 200, data: [.get: resultData])
        mock.register()

        #expect(viewModel.offSet == 0)

        try await viewModel.fetchResults()

        #expect(viewModel.sections.count == 1)
        #expect(viewModel.sections.first?.items.count == 10)
        #expect(viewModel.offSet == 20)

        try await viewModel.fetchResults()
        #expect(viewModel.sections.count == 2)
        #expect(viewModel.offSet == 40)
    }
}
