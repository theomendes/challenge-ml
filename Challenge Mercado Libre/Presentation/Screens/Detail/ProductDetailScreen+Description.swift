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

                ForEach(item.attributes) { attribute in
                    HStack {
                        Text(attribute.name)
                            .bold()
                        Text(attribute.value)
                    }
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    ProductDetailScreen.Description(item: .mock)
}
