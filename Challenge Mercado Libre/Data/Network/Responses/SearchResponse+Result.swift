//
//  SearchResponse+Item.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import Foundation

extension SearchResponse {
    struct Result {
        let id: String
        let title: String
        let thumbnail: URL
    }
}

extension SearchResponse.Result: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
    }
}
