//
//  QueryVC+Actions.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation

extension QueryVC {
    @MainActor
    func searchWithQuery(_ query: String) {
        @Injected(\.networkProvider) var networkProvider

        let repository = SearchResultRepository(service: networkProvider.searchService)
        let useCase = SearchUseCase(repository: repository)
        let viewModel = SearchResultVM(
            useCase: useCase,
            query: .init(
                text: query,
                siteID: "MLB",
                category: nil
            ))
        let vc = SearchResultVC(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func searchButtonTapped() {
        generator.impactOccurred()

        if let text = searchField.text {
            searchWithQuery(text)
        }
    }
}
