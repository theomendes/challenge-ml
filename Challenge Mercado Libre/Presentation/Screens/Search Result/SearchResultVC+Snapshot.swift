//
//  SearchResultVC+Snapshot.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import UIKit

extension SearchResultVC {
    func applySnapshot(with items: [SearchResultItem]) async {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)

        await dataSource.apply(snapshot, animatingDifferences: false)
    }
}
