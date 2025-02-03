//
//  SearchResultVC+UICollectionViewDelegate.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import UIKit

extension SearchResultVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let selectedItem = dataSource.itemIdentifier(for: indexPath) {
            logger.log(level: .info, "Did display cell for item with ID: \(selectedItem.id)")
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        logger.log(level: .info, "Did select item with ID: \(selectedItem.id)")
        goToDetail(for: selectedItem)
    }
}
