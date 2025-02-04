//
//  SearchResultVC+UICollectionViewDataSourcePrefetching.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import UIKit

extension SearchResultVC: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: shouldLoadMore) {
            logger.log(level: .info, "Loading more results...")
            getResults(isLoadingMore: true)
        }
    }

    private func shouldLoadMore(for indexPath: IndexPath) -> Bool {
        let isLastSection = (indexPath.section + 1) == self.dataSource.snapshot().numberOfSections

        let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let items = self.dataSource.snapshot().numberOfItems(inSection: section)

        if isLastSection && ((indexPath.row + 1) >= (items - 2)) {
            return true
        }
        return false
    }
}
