//
//  SearchFilterVC+Layout.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 04/02/25.
//

import UIKit

extension SearchFilterVC {
    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            config.headerMode = .supplementary
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
}
