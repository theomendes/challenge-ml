//
//  SearchFilterVC+UICollectionViewDelegate.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 04/02/25.
//

import UIKit

extension SearchFilterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let selectedSection = dataSource.snapshot().sectionIdentifiers[indexPath.section]

        handleSelection(for: selectedItem, in: selectedSection)
    }

    private func handleSelection(for item: SearchResultFilter.Values, in section: SearchResultFilter) {
        if let sectionIndex = filters.firstIndex(where: { $0.id == section.id }) {
            for itemIndex in filters[sectionIndex].values.indices {
                filters[sectionIndex].values[itemIndex].isSelected = false
            }

            if let itemIndex = filters[sectionIndex].values.firstIndex(where: { $0.id == item.id }) {
                filters[sectionIndex].values[itemIndex].isSelected = true
            }

            delegate?.didSelectedFilter(item.idValue, from: section.id)

            applySnapshot(withSections: [])
            applySnapshot(withSections: filters, animatingDifferences: true)
        }
    }
}
