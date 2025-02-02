//
//  ProductDetailScreen.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import SwiftUI

struct ProductDetailScreen: View {
    let item: SearchResultItem

    var body: some View {
        VStack(alignment: .leading) {
            Text("Novo")
            Header(item: item) { url in
                print(url.absoluteString)
            }

            priceView
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    var priceView: some View {
        VStack(alignment: .leading) {
            Text(item.price.formatedAmount)
                .font(.title)
                .foregroundStyle(.black)

            if let installments = item.price.installments, installments.quantity > 0 {
                Text("em \(installments.quantity)x \(installments.formatedAmount)")
                    .font(.subheadline)
                    .foregroundStyle(.green)
            }
        }
    }
}

#Preview {
    ProductDetailScreen(item: .mock)
}
