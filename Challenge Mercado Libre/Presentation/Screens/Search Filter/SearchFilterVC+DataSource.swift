//
//  SearchFilterVC+DataSource.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 04/02/25.
//

import UIKit

extension SearchFilterVC {
    func configureDataSourceProvider() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { (supplementaryView, _, indexPath) in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            var content = supplementaryView.defaultContentConfiguration()
            content.text = section.name
            supplementaryView.contentConfiguration = content
        }

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResultFilter.Values> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content

            if item.isSelected {
                cell.accessories = [.checkmark()]
            } else {
                cell.accessories = []
            }
        }

        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: SearchResultFilter.Values) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: indexPath)
        }

    }

    func applySnapshot(withSections sections: [SearchResultFilter], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()

        snapshot.appendSections(sections)

        sections.forEach { section in
            snapshot.appendItems(section.values, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
