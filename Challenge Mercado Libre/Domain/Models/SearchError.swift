//
//  SearchError.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 02/02/25.
//

import Foundation

enum SearchError: Error, Equatable {
    case internetConnection
    case emptyResults(query: String)
    case serviceError(code: String, msmsg: String)
    case generic
}

extension SearchError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .internetConnection:
            return NSLocalizedString("search_error_no_internet_connection", comment: "No internet connection error description")
        case .emptyResults(let query):
            return String(format: NSLocalizedString("search_error_no_results_found", comment: "No results found error description"), query)
        case .serviceError(let code, let message):
            return String(format: NSLocalizedString("search_error_service_error", comment: "Service error description"), code, message)
        case .generic:
            return NSLocalizedString("search_error_generic_error", comment: "Generic error description")
        }
    }
}
