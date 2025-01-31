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
}

extension SearchResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case paging
    }
}
