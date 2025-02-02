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
    @Published var sections = [SearchResultSection]()
    private var limit = 20
    private var offSet = 0
    private var isLoading = false

    init(useCase: SearchUseCase, query: Query) {
        self.useCase = useCase
        self.query = query
    }

    func fetchResults() async throws {
        guard !isLoading else { return }

        isLoading = true
        let results = try await useCase.execute(
            for: query.text,
            on: query.siteID,
            category: query.category,
            limit: limit,
            offset: offSet
        )
        sections.append(contentsOf: results)
        
        offSet += limit
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
