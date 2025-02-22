//
//  SearchService.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

protocol SearchServiceType: ServiceType {
    func search(_ q: String, siteID: String, category: String?, limit: Int, offset: Int, filters: [String : String]?, cache: CachedResponseHandler) async -> DataResponse<SearchResponse, AFError>
}

final class SearchService: SearchServiceType {
    var session: Session

    init(session: Session) {
        self.session = session
    }

    func search(_ q: String, siteID: String, category: String? = nil, limit: Int, offset: Int, filters: [String : String]?, cache: CachedResponseHandler = .cache) async -> DataResponse<SearchResponse, AFError> {
        let api = SearchAPI(query: q, siteID: siteID, category: category, limit: limit, offset: offset, filters: filters)

        return await request(api, cache: cache)
    }
}
