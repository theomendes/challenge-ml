//
//  SearchItemPrice.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import Foundation

struct SearchItemPrice: Hashable {
    let amount: Decimal
    let originalAmount: Decimal?
    let currency: String
    let formatedAmount: String

    var discountPercentage: Int? {
        guard let originalAmount, originalAmount > 0 else {
            return nil
        }
        let discount = NSDecimalNumber(decimal: ((originalAmount - amount) / originalAmount * 100))
        return discount.intValue
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
