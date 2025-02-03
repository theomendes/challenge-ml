//
//  SearchVM.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import Foundation

final class SearchResultVM {
    private let useCase: SearchUseCase
    let query: Query
    @Published var items = [SearchResultItem]()
    private(set) var limit = 20
    private(set) var offSet = 0
    private(set) var isLoading = false
    @Published var filters = [SearchResultFilter]()

    init(useCase: SearchUseCase, query: Query) {
        self.useCase = useCase
        self.query = query
    }

    func fetchResults() async throws {
        guard !isLoading else { return }

        isLoading = true
        let result = try await useCase.execute(
            for: query.text,
            on: query.siteID,
            category: query.category,
            limit: limit,
            offset: offSet
        )

        filters = result.filters
        items.append(contentsOf: result.items)

        offSet = result.offset
        isLoading = false
    }
}

extension SearchResultVM {
    struct Query {
        var text: String
        var siteID: String
        var category: String?
    }
}
