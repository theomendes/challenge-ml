//
//  SearchUseCase.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation

protocol SearchUseCaseType {
    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int) async throws -> SearchResponse
}

final class SearchUseCase: SearchUseCaseType {
    private var repository: SearchRepositoryType

    init(repository: SearchRepositoryType) {
        self.repository = repository
    }

    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int) async throws -> SearchResponse {
        let response = await repository.getResults(query, siteID: siteID, category: category, limit: limit, offset: offset)

        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
