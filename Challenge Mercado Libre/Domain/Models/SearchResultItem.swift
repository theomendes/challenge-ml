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
    let permalink: URL
}

extension SearchResultItem {
    static var mock: SearchResultItem {
        .init(
            id: "MLB5097135428",
            title: "Apple Watch Series 10",
            thumbnail: URL(string: "http://http2.mlstatic.com/D_837437-MLA79083751040_092024-I.jpg")!,
            price: .init(
                amount: 5499,
                originalAmount: 6799,
                currency: "BRL",
                formatedAmount: "R$ 5499",
                installments: .init(
                    quantity: 10,
                    amount: 549.90,
                    currency: "BRL",
                    formatedAmount: "R$ 549,90")),
            freeShipping: true,
            officialStore: "Apple",
            permalink: URL(string: "https://www.mercadolivre.com.br/apple-watch-se-gps-caixa-estelar-de-aluminio-40-mm-pulseira-esportiva-estelar-pm/p/MLB27366066#wid=MLB5256403412&sid=unknown")!
        )
    }
}
