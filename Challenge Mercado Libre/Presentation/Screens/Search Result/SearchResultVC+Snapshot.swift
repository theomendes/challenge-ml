//
//  SearchResultVC+Snapshot.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import UIKit

extension SearchResultVC {
    func applySnapshot(with sections: [SearchResultSection]) async {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach {
            snapshot.appendItems($0.items)
        }

        dataSource.apply(snapshot, animatingDifferences: false) { [weak self] in
            self?.showIsLoading(false)
        }
    }
}
