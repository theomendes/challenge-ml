//
//  DeepLink.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation

enum DeepLink {
    case search(query: String, siteID: String, category: String?)
}

extension DeepLink {
    init?(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        let queryItems = Dictionary(uniqueKeysWithValues: components
            .queryItems?
            .compactMap { item in
                item.value.map { (item.name, $0) }
            } ?? [])

        switch components.host {
        case "search":
            guard let q = queryItems["q"], let siteId = queryItems["siteId"] else { return nil }
            self = .search(query: q, siteID: siteId, category: queryItems["category"])
        default:
            return nil
        }
    }
}
