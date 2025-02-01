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

    init(useCase: SearchUseCase, query: Query) {
        self.useCase = useCase
        self.query = query
    }

    func fetchResults() async {
        do {
            sections = try await useCase.execute(
                for: query.text,
                on: query.siteID,
                category: query.category,
                limit: limit,
                offset: offSet
            )
            offSet += limit
        } catch {

        }
    }
}

extension SearchResultVM {
    struct Query {
        var text: String
        var siteID: String
        var category: String?
    }
}
