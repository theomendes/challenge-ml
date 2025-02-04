//
//  RequestTypeTests.swift
//  Challenge Mercado LibreTests
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation
import Testing
@testable import Challenge_Mercado_Libre

@Suite("Request Type Tests")
struct RequestTypeTests {
    @Test("Testing default values")
    func testingDefaultValues() async throws {
        let mock = DefaultValuesRequestTypeMock()
        #expect(mock.method == .get)
        #expect(mock.headers["Content-Type"] == "application/json")
    }

    @Test("Testing request without parameters")
    func testingPlainParameters() async throws {
        let mock = RequestTypeMock(parameters: .plain)
        let urlRequest = try mock.asURLRequest()
        guard let url = urlRequest.url else {
            Issue.record("URL Request should not be nil")
            return
        }
        let requestParameters = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems

        #expect(requestParameters == nil)
    }

    @Test("Testing request with parameters")
    func testingQueryParameters() async throws {
        let parameters = [
            "site_id": "MLB",
        ]
        let mock = RequestTypeMock(parameters: .parameters(parameters: parameters, encoding: URLEncoding.queryString))
        let urlRequest = try mock.asURLRequest()
        guard let url = urlRequest.url else {
            Issue.record("URL Request should not be nil")
            return
        }
        let requestParameters = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems

        #expect(requestParameters?.first?.value == "MLB")
    }

    @Test("Testing invalid path")
    func testingInvalidPath() async throws {
        #expect(throws: RequestTypeError.unableToCreateURLRequest) {
            try InvalidPathRequestTypeMock().asURLRequest()
        }
    }
}
