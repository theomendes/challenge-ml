//
//  SearchResultVC+DataSource.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import UIKit

extension SearchResultVC {
    func configureDataSourceProvider() {
        let itemRegistration = UICollectionView.CellRegistration<SwiftUIHostCVC<SearchResultItemView>, SearchResultItem> { [weak self] cell, indexPath, item in
            cell.configure(with: .init(item: item), in: self)
        }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: itemRegistration, for: indexPath, item: itemIdentifier)
        }

    }
}
