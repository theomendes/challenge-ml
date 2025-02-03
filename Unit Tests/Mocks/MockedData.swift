//
//  MockedData.swift
//  Unit Tests
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation

enum MockedData {
    static let searchService: URL = {
        guard let url = Bundle(for: MockSession.self).url(forResource: "SearchServiceResponse", withExtension: "json") else {
            fatalError("Missing file: SearchServiceResponse.json")
        }
        return url
    }()

    static let searchServiceNoResult: URL = {
        guard let url = Bundle(for: MockSession.self).url(forResource: "SearchServiceNoResultsResponse", withExtension: "json") else {
            fatalError("Missing file: SearchServiceNoResultsResponse.json")
        }
        return url
    }()

    static let custom403Error: URL = {
        guard let url = Bundle(for: MockSession.self).url(forResource: "403CustomError", withExtension: "json") else {
            fatalError("Missing file: 403CustomError.json")
        }
        return url
    }()

    static let decoding403Error: URL = {
        guard let url = Bundle(for: MockSession.self).url(forResource: "403DecodingError", withExtension: "json") else {
            fatalError("Missing file: 403DecodingError.json")
        }
        return url
    }()
}
