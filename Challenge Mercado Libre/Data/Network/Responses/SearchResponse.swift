//
//  SearchResponse.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation

struct SearchResponse {
    let siteId: String
    let paging: Paging
    let results: [Result]
    let sort: SortBy?
    let filters: [FilterCategory]?
    let availableFilters: [FilterCategory]
    let availableSorts: [SortBy]
}

extension SearchResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case paging
        case results
        case sort
        case filters
        case availableFilters = "available_filters"
        case availableSorts = "available_sorts"
    }
}
