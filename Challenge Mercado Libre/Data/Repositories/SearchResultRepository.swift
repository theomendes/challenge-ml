//
//  SearchRepository.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

protocol SearchResultRepositoryType {
    func getResults(_ q: String, siteID: String, category: String?, limit: Int, offset: Int) async -> DataResponse<SearchResponse, AFError>
}

final class SearchResultRepository: SearchResultRepositoryType {
    private let service: SearchServiceType

    init(service: SearchServiceType) {
        self.service = service
    }

    func getResults(_ q: String, siteID: String, category: String?, limit: Int, offset: Int) async -> DataResponse<SearchResponse, AFError> {
        await service.search(q, siteID: siteID, category: category, limit: limit, offset: offset, cache: .cache)
    }
}
