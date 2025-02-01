//
//  SearchUseCase.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation
import OSLog

protocol SearchUseCaseType {
    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int) async throws -> [SearchSection]
}

final class SearchUseCase: SearchUseCaseType {
    private var repository: SearchRepositoryType
    private let logger = Logger(subsystem: "com.theo.Challenge-Mercado-Libre", category: "SearchUseCase")

    init(repository: SearchRepositoryType) {
        self.repository = repository
    }

    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int) async throws -> [SearchSection] {
        logger.log(level: .info, "Starting execute for query: \(query), on site: \(siteID), with category: \(category ?? "nil"), limit: \(limit), offset: \(offset)")
        let response = await repository.getResults(query, siteID: siteID, category: category, limit: limit, offset: offset)

        switch response.result {
        case .success(let result):
            logger.log(level: .info, "Returned \(result.paging.total) results for query: \(query)")
            return convertToSections(result)
        case .failure(let error):
            logger.error("\(error.localizedDescription)")
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
