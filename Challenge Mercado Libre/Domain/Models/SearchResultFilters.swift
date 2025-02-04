//
//  SearchResultFilters.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation

final class SearchResultFilter: Hashable {
    var id: String
    let name: String
    let type: String
    var values: [Values]

    init(id: String, name: String, type: String, values: [Values]) {
        self.id = id
        self.name = name
        self.type = type
        self.values = values
    }

    static func == (lhs: SearchResultFilter, rhs: SearchResultFilter) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.type == rhs.type && lhs.values == rhs.values
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(values)
    }
}

extension SearchResultFilter {
    final class Values: Hashable {
        let id = UUID()
        let idValue: String
        let name: String
        let results: Int?
        var isSelected: Bool

        init(id: String, name: String, results: Int?, isSelected: Bool) {
            self.idValue = id
            self.name = name
            self.results = results
            self.isSelected = isSelected
        }

        static func == (lhs: Values, rhs: Values) -> Bool {
            return lhs.id == rhs.id && lhs.name == rhs.name && lhs.results == rhs.results && lhs.isSelected == rhs.isSelected
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(results)
            hasher.combine(isSelected)
        }
    }
}
