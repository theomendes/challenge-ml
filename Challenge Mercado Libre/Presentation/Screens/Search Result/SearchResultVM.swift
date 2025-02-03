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
    private(set) var appliedFilters: [String: String] = [:]
    private(set) var selectedFilters: [String: String] = [:]

    init(useCase: SearchUseCase, query: Query) {
        self.useCase = useCase
        self.query = query
    }

    func fetchResults(loadMore: Bool = false) async throws {
        guard !isLoading else { return }

        isLoading = true

        let result = try await useCase.execute(
            for: query.text,
            on: query.siteID,
            category: query.category,
            limit: limit,
            offset: offSet,
            filters: appliedFilters
        )

        if loadMore {
            items.append(contentsOf: result.items)
        } else {
            self.filters = result.filters
            items = result.items
        }

        offSet += result.limit
        isLoading = false
    }

    func selectedFilter(_ filter: String, from sectionID: String) {
        selectedFilters[sectionID] = filter
    }

    func resetFilters() {
        selectedFilters.removeAll()
        appliedFilters.removeAll()
    }

    func cleanSelectedFiltres() {
        selectedFilters.removeAll()
    }

    func applyFilters() {
        appliedFilters = selectedFilters
        selectedFilters.removeAll()
    }
}

extension SearchResultVM {
    struct Query {
        var text: String
        var siteID: String
        var category: String?
    }
}
