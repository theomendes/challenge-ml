//
//  SearchItem.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import Foundation

struct SearchResultItem: Identifiable, Hashable {
    let id: String
    let title: String
    let thumbnail: URL
    let price: SearchItemPrice
    let freeShipping: Bool
    let officialStore: String?
}
