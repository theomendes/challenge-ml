//
//  ProductDetailScreen+Description.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import SwiftUI

extension ProductDetailScreen {
    struct Description: View {
        private let item: SearchResultItem

        init(item: SearchResultItem) {
            self.item = item
        }

        var body: some View {
            VStack(alignment: .leading) {
                if let officialStore = item.officialStore {
                    HStack {
                        Text("Official store \(officialStore)")
                            .foregroundStyle(.gray)
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.blue)
                    }
                    .font(.footnote)
                    .padding(.bottom)
                }

                Text("Characteristics")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .padding(.bottom, 10)

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(item.attributes) { attribute in
                        VStack(alignment: .leading) {
                            Text(attribute.name)
                                .textCase(.uppercase)
                                .bold()
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Text(attribute.value)
                                .foregroundStyle(.black)
                        }
                        .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    ProductDetailScreen.Description(item: .mock)
}
