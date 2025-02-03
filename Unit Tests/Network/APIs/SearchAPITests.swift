//
//  SearchAPITests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation
import Testing
@testable import Challenge_Mercado_Libre

@Suite("Search API Tests")
struct SearchAPITests {

    @Test("Testing Search Query Parameters Without Category")
    func testingSearchQueryParametersWithoutCategory() async throws {
        let api = SearchAPI(query: "Apple Watch", siteID: "MLB", category: nil, limit: 10, offset: 0, filters: nil)
        let urlRequest = try api.asURLRequest()

        guard let queryItems = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)?.queryItems else {
            Issue.record("Query items not found")
            return
        }
        let queryDict = Dictionary(uniqueKeysWithValues: queryItems.map { ($0.name, $0.value ?? "") })
        #expect(queryDict["q"] == "Apple Watch")
        #expect(queryDict["limit"] == "10")
        #expect(queryDict["offset"] == "0")
        #expect(!queryDict.keys.contains(where: { $0 == "category" }))
    }

    @Test("Testing Search Query Parameters With Category")
    func testingSearchQueryParametersWithCategory() async throws {
        let api = SearchAPI(query: "Apple Watch", siteID: "MLB", category: "MLB1648", limit: 10, offset: 0, filters: nil)
        let urlRequest = try api.asURLRequest()

        guard let queryItems = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)?.queryItems else {
            Issue.record("Query items not found")
            return
        }
        let queryDict = Dictionary(uniqueKeysWithValues: queryItems.map { ($0.name, $0.value ?? "") })
        #expect(queryDict["q"] == "Apple Watch")
        #expect(queryDict["limit"] == "10")
        #expect(queryDict["offset"] == "0")
        #expect(queryDict["category"] == "MLB1648")
    }

}
