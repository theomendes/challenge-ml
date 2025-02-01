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
        let salePrice: Price
        let officialStoreName: String?
        let shipping: Shipping
    }
}

extension SearchResponse.Result: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case salePrice = "sale_price"
        case officialStoreName = "official_store_name"
        case shipping
    }
}

extension SearchResponse.Result {
    struct Price: Decodable {
        let amount: Decimal
        let regularAmount: Decimal?
        let currency: String

        enum CodingKeys: String, CodingKey {
            case amount
            case regularAmount = "regular_amount"
            case currency = "currency_id"
        }
    }
}

extension SearchResponse.Result {
    struct Shipping: Decodable {
        let freeShipping: Bool

        enum CodingKeys: String, CodingKey {
            case freeShipping = "free_shipping"
        }
    }
}

extension SearchResponse.Result {
    struct Installments: Decodable {
        let quantity: Int
        let amount: Decimal
        let rate: Decimal
    }
}
