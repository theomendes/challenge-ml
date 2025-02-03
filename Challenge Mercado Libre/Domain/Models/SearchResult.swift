//
//  SearchResult.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation

struct SearchResult {
    let items: [SearchResultItem]
    let total: Int
    let primaryResults: Int
    let offset: Int
    let limit: Int
    let filters: [SearchResultFilter]
}
