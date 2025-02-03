//
//  SearchResultVC+Actions.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import UIKit

extension SearchResultVC {
    func goToDetail(for item: SearchResultItem) {
        let vc = ProductDetailVCWrapper(item: item)
        navigationController?.pushViewController(vc, animated: true)
    }
}
