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

    func goToFilter(with filters: [SearchResultFilter]) {
        let vc = SearchFilterVC(filters: filters)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.presentationController?.delegate = self
        present(nav, animated: true)
    }
}

extension SearchResultVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        viewModel.cleanSelectedFiltres()
    }
}
