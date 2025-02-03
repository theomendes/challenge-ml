//
//  SearchItemPrice.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import Foundation

struct SearchItemPrice: Hashable {
    let amount: Double
    let originalAmount: Double?
    let currency: String
    let formatedAmount: String
    let installments: Installments?

    var discountPercentage: Int? {
        guard let originalAmount, originalAmount > 0 else {
            return nil
        }

        let discount = ((originalAmount - amount) / originalAmount) * 100
        return Int(discount)
    }
}

extension SearchItemPrice {
    struct Installments: Hashable {
        let quantity: Int
        let amount: Decimal
        let currency: String
        let formatedAmount: String
    }
}
