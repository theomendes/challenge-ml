//
//  SearchResultVC+SearchFilterVCDelegate.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation

extension SearchResultVC: SearchFilterVCDelegate {
    func applyFilters() {
        
    }
    
    func didSelectedFilter(_ filter: String, from sectionID: String) {
        print("Did selected filter: \(filter), from section: \(sectionID)")
    }
}
