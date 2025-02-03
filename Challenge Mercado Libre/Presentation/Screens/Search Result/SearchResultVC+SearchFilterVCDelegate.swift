//
//  SearchResultVC+SearchFilterVCDelegate.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation

extension SearchResultVC: SearchFilterVCDelegate {
    func applyFilters() {
        viewModel.applyFilters()
        getResults(isLoadingMore: false)
    }
    
    func didSelectedFilter(_ filter: String, from sectionID: String) {
        logger.log(level: .info, "Did selected filter: \(filter), from section: \(sectionID)")
        viewModel.selectedFilter(filter, from: sectionID)
    }

    func resetFilters() {
        viewModel.resetFilters()
        getResults(isLoadingMore: false)
    }
}
