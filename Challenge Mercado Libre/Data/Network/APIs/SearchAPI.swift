//
//  SearchAPI.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

struct SearchAPI: RequestType {
    typealias Response = SearchResponse

    let query: String
    let siteID: String
    let category: String?
    let limit: Int
    let offset: Int
    let filters: [String: String]?

    var path: String {
        "/sites/\(siteID)/search"
    }

    var method: HTTPMethod {
        .get
    }

    var parameters: APIParameters {
        var params: Alamofire.Parameters = [
            "q": query,
            "limit": limit,
            "offset": offset
        ]

        if let category = category {
            params["category"] = category
        }

        if let filters = filters {
            params.merge(filters) { (_, new) in new }
        }

        return .parameters(parameters: params, encoding: URLEncoding.queryString)
    }
}
