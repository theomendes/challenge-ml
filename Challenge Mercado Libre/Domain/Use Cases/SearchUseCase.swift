//
//  SearchUseCase.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation
import OSLog

protocol SearchResultUseCaseType {
    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int) async throws -> [SearchResultSection]
}

final class SearchUseCase: SearchResultUseCaseType {
    private var repository: SearchResultRepositoryType
    private let logger = Logger(subsystem: "com.theo.Challenge-Mercado-Libre", category: "SearchUseCase")

    init(repository: SearchResultRepositoryType) {
        self.repository = repository
    }

    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int) async throws -> [SearchResultSection] {
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
    private func convertToSections(_ response: SearchResponse) -> [SearchResultSection] {
        let items = response.results.map { result in
            SearchResultItem(id: result.id, title: result.title, thumbnail: result.thumbnail)
        }
        return [
            SearchResultSection(items: items)
        ]
    }
}
