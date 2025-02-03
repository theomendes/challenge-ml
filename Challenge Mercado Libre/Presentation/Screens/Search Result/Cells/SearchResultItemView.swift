//
//  SearchResultItemView.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import SwiftUI

struct SearchResultItemView: View {
    let item: SearchResultItem

    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: item.thumbnail) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 130, height: 130)
            .aspectRatio(1, contentMode: .fit)
            .clipped()

            VStack(alignment: .leading, spacing: 10) {
                titleView

                priceView

                if item.freeShipping {
                    Text("Free shipping")
                        .font(.caption)
                        .foregroundStyle(.black)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical)
        .background(alignment: .bottomLeading) {
            Divider()
        }
    }

    @ViewBuilder
    var titleView: some View {
        VStack(alignment: .leading) {
            if let officialStore = item.officialStore, officialStore == "Apple" {
                Text("Official store \(officialStore)")
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
                .font(.subheadline)
                .lineLimit(3)
                .foregroundStyle(.black)

            if let officialStore = item.officialStore {
                HStack {
                    Text("By \(officialStore)")
                        .foregroundStyle(.gray)
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.blue)
                }
                .font(.footnote)
            }
        }
    }

    @ViewBuilder
    var priceView: some View {
        Text(item.price.formatedAmount)
            .font(.caption)
            .foregroundStyle(.black)
    }
}

#Preview {
    SearchResultItemView(item: .mock)
}
