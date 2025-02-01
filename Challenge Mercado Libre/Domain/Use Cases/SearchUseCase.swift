//
//  SearchUseCase.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation

protocol SearchUseCaseType {
    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int) async throws -> [SearchSection]
}

final class SearchUseCase: SearchUseCaseType {
    private var repository: SearchRepositoryType

    init(repository: SearchRepositoryType) {
        self.repository = repository
    }

    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int) async throws -> [SearchSection] {
        let response = await repository.getResults(query, siteID: siteID, category: category, limit: limit, offset: offset)

        switch response.result {
        case .success(let result):
            return convertToSections(result)
        case .failure(let error):
            throw error
        }
    }
}

extension SearchUseCase {
    private func convertToSections(_ response: SearchResponse) -> [SearchSection] {
        let items = response.results.map { result in
            SearchItem(id: result.id, title: result.title, thumbnail: result.thumbnail)
        }
        return [
            SearchSection(items: items)
        ]
    }
}
