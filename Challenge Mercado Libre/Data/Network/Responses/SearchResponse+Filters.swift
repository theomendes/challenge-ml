//
//  SearchResponse+Filters.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation

extension SearchResponse {
    struct FilterCategory: Decodable {
        let id: String
        let name: String
        let type: String
        let values: [FilterValue]
    }
}

extension SearchResponse {
    struct FilterValue: Decodable {
        let id: String
        let name: String
        let results: Int?
    }
}
