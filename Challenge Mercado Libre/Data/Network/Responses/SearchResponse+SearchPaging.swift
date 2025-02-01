//
//  SearchPaging.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation

extension SearchResponse {
    struct Paging {
        let total: Int
        let primaryResults: Int
        let offset: Int
        let limit: Int
    }
}

extension SearchResponse.Paging: Decodable {
    enum CodingKeys: String, CodingKey {
        case total, offset, limit
        case primaryResults = "primary_results"
    }
}
