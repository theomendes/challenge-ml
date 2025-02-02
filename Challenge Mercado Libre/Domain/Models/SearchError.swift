//
//  SearchError.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 02/02/25.
//

import Foundation

enum SearchError: Error {
    case internetConnection
    case emptyResults(query: String)
    case serviceError(code: String, msmsg: String)
    case generic
}

extension SearchError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .internetConnection:
            return "No internet connection. Please check your network and try again."
        case .emptyResults(let query):
            return "No results found for \"\(query)\".\nTry searching for something else."
        case .serviceError(let code, let message):
            return "Service error (\(code)): \(message).\nPlease try again later."
        case .generic:
            return "An unknown error occurred."
        }
    }
}
