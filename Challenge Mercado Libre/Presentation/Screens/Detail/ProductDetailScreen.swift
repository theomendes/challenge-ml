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
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                if item.condition == "new" {
                    Text("New")
                }
                Header(item: item)

                priceView

                Description(item: item)
                    .padding(.top)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .background(Color.white)
    }

    @ViewBuilder
    var priceView: some View {
        VStack(alignment: .leading) {
            Text(item.price.formatedAmount)
                .font(.title)
                .foregroundStyle(.black)

            if let installments = item.price.installments, installments.quantity > 0 {
                Text("In \(installments.quantity)x \(installments.formatedAmount)")
                    .font(.subheadline)
                    .foregroundStyle(installments.rate == 0 ? .green : .black)
            }
        }
    }
}

#Preview {
    ProductDetailScreen(item: .mock)
}
