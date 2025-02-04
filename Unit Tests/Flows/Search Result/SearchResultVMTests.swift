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
        #expect(viewModel.items.isEmpty)
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

        #expect(viewModel.items.count == 10)
        #expect(viewModel.offSet == 10)

        try await viewModel.fetchResults(loadMore: true)
        #expect(viewModel.items.count == 20)
        #expect(viewModel.offSet == 20)
    }

    @Test("Testing filter logic")
    func testingFilterLogic() async throws {
        viewModel.selectedFilter("asc", from: "sort")
        #expect(viewModel.selectedFilters.count == 1)

        viewModel.cleanSelectedFiltres()
        #expect(viewModel.selectedFilters.isEmpty)

        viewModel.selectedFilter("asc", from: "sort")
        #expect(viewModel.selectedFilters.count == 1)

        viewModel.applyFilters()
        #expect(viewModel.appliedFilters.count == 1)
        #expect(viewModel.selectedFilters.isEmpty)

        viewModel.selectedFilter("asc", from: "sort")
        #expect(viewModel.selectedFilters.count == 1)
        viewModel.resetFilters()
        #expect(viewModel.selectedFilters.isEmpty)
        #expect(viewModel.appliedFilters.isEmpty)
    }
}
