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
        let permalink: URL
        let condition: String
        let installments: Installments?
        let attributes: [Attribute]
        let seller: Seller
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
        case permalink
        case condition
        case installments
        case attributes
        case seller
    }
}

extension SearchResponse.Result {
    struct Price: Decodable {
        let amount: Double
        let regularAmount: Double?
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
        let rate: Double
        let currency: String

        enum CodingKeys: String, CodingKey {
            case quantity
            case amount
            case rate
            case currency = "currency_id"
        }
    }
}

extension SearchResponse.Result {
    struct Attribute: Decodable {
        let id: String
        let name: String
        let value: String?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case value = "value_name"
        }
    }
}

extension SearchResponse.Result {
    struct Seller: Decodable {
        let id: Int
        let nickname: String
    }
}
