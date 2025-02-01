//
//  SearchVM.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import Foundation

final class SearchVM {
    private let useCase: SearchUseCase
    @Published var sections = [SearchSection]()

    init(useCase: SearchUseCase) {
        self.useCase = useCase
        self.sections = sections
    }

    func fetch(for query: String, limit: Int, offSet: Int) async {
        do {
            sections = try await useCase.execute(for: query, on: "MLB", category: nil, limit: limit, offset: offSet)
        } catch {

        }
    }
}
