//
//  SearchResponse+SortBy.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation

extension SearchResponse {
    struct SortBy: Decodable {
        let id: String
        let name: String
    }
}
