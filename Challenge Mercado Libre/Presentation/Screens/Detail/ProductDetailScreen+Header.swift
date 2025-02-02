//
//  ProductDetailScreen+Header.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import SwiftUI

extension ProductDetailScreen {
    struct Header: View {
        private let item: SearchResultItem
        private var didTapShare: ((URL) -> Void)? = nil

        init(item: SearchResultItem, didTapShare: ((URL) -> Void)? = nil) {
            self.item = item
            self.didTapShare = didTapShare
        }

        var body: some View {
            VStack(alignment: .leading) {
                if let officialStore = item.officialStore, officialStore == "Apple" {
                    Text("Loja oficial \(officialStore)")
                        .textCase(.uppercase)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 3)
                        .background(Color.black)
                        .foregroundStyle(.white)
                        .cornerRadius(2)
                }

                Text(item.title)
                    .font(.headline)
                    .lineLimit(3)
                    .foregroundStyle(.black)
                    .padding(.bottom)

                AsyncImage(url: item.thumbnail) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity
                )
                .aspectRatio(1, contentMode: .fit)
                .clipped()
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        didTapShare?(item.permalink)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ProductDetailScreen.Header(item: .mock)
}
