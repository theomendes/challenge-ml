//
//  SearchUseCase.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation
import OSLog

protocol SearchResultUseCaseType {
    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int, filters: [String : String]?) async throws -> SearchResult
}

final class SearchUseCase: SearchResultUseCaseType {
    private var repository: SearchResultRepositoryType
    private let logger = Logger(subsystem: "com.theo.Challenge-Mercado-Libre", category: "SearchUseCase")

    private var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    init(repository: SearchResultRepositoryType) {
        self.repository = repository
    }

    func execute(for query: String, on siteID: String, category: String?, limit: Int, offset: Int, filters: [String : String]?) async throws -> SearchResult {
        logger.log(level: .info, "Starting execute for query: \(query), on site: \(siteID), with category: \(category ?? "nil"), limit: \(limit), offset: \(offset)")
        let response = await repository.getResults(query, siteID: siteID, category: category, limit: limit, offset: offset, filters: filters)

        switch response.result {
        case .success(let result):
            logger.log(level: .info, "Returned \(result.paging.total) results for query: \(query)")
            if result.paging.total == 0 {
                throw SearchError.emptyResults(query: query)
            }
            return SearchResult(
                items: convertToSections(result),
                total: result.paging.total,
                primaryResults: result.paging.primaryResults,
                offset: result.paging.offset,
                limit: result.paging.limit,
                filters: convertFilters(result))
            
        case .failure(let error):
            logger.error("\(error.localizedDescription)")
            if let internetError = verifyInternetError(error) {
                throw internetError
            } else {
                if let data = response.data, let serviceError = try? decodeServiceError(data: data) {
                    throw SearchError.serviceError(code: serviceError.code, msmsg: serviceError.message)
                }
            }
            throw SearchError.generic
        }
    }
}

extension SearchUseCase {
    private func convertToSections(_ response: SearchResponse) -> [SearchResultItem] {
        return response.results.map { [weak self] result in
            var installments: SearchItemPrice.Installments? = nil
            if let installmentsData = result.installments {
                installments = .init(
                    quantity: installmentsData.quantity,
                    amount: installmentsData.amount,
                    currency: installmentsData.currency,
                    formatedAmount: self?.formatCurrency(amount: installmentsData.amount as NSNumber, currency: installmentsData.currency) ?? ""
                )
            }
            return SearchResultItem(
                productID: result.id,
                title: result.title,
                thumbnail: result.thumbnail,
                price: .init(
                    amount: result.salePrice.amount,
                    originalAmount: result.salePrice.regularAmount,
                    currency: result.salePrice.currency,
                    formatedAmount: self?.formatCurrency(amount: result.salePrice.amount as NSNumber, currency: result.salePrice.currency) ?? "",
                    installments: installments
                ),
                freeShipping: result.shipping.freeShipping,
                officialStore: result.officialStoreName,
                permalink: result.permalink,
                attributes: result.attributes.map({ SearchResultItem.Attribute(id: $0.id, name: $0.name, value: $0.value ?? "") })
            )
        }
    }

    private func convertFilters(_ response: SearchResponse) -> [SearchResultFilter] {
        let sort = response.sort
        var filters = [SearchResultFilter]()

        var sortFilters = response.availableSorts.map { sortOption in
            SearchResultFilter.Values(id: sortOption.id, name: sortOption.name, results: nil, isSelected: false)
        }

        if let sort {
            sortFilters.insert(.init(id: sort.id, name: sort.name, results: nil, isSelected: true), at: 0)
        }

        if !sortFilters.isEmpty {
            filters.append(.init(id: "sort", name: NSLocalizedString("search_filter_sort_by", comment: "Sort by"), type: "sortBy", values: sortFilters))
        }

        for filter in response.availableFilters {
            let values = filter.values.map { value in
                return SearchResultFilter.Values(id: value.id, name: value.name, results: value.results, isSelected: false)
            }
            filters.append(.init(id: filter.id, name: filter.name, type: filter.type, values: values))
        }

        return filters
    }

    private func formatCurrency(amount: NSNumber, currency: String) -> String {
        numberFormatter.currencyCode = currency
        return numberFormatter.string(from: amount) ?? ""
    }

    private func decodeServiceError(data: Data) throws -> APIError {
        return try JSONDecoder().decode(APIError.self, from: data)
    }

    private func verifyInternetError(_ error: AFError) -> SearchError? {
        if let underlyingError = error.underlyingError as? URLError {
            switch underlyingError.code {
            case .notConnectedToInternet, .networkConnectionLost, .timedOut:
                return .internetConnection
            default:
                return nil
            }
        }
        return nil
    }
}
