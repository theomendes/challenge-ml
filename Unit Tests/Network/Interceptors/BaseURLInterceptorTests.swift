//
//  BaseURLInterceptorTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 31/01/25.
//

import Testing
import Alamofire
import Foundation
import Mocker
@testable import Challenge_Mercado_Libre

@Suite("Base URL Interceptor Tests")
struct BaseURLInterceptorTests {
    private let session: Session

    init() {
        let interceptor = Interceptor(adapters: [
            BaseURLInterceptor(baseURL: URL(string: "https://api.mercadolibre.com")!)
        ])

        self.session = MockSession.createMockSession(with: interceptor)
    }

    @Test("Testing if base URL is added to request")
    func testingBaseURLisAddedToRequest() async throws {
        let url = URL(string: "/sites/MLB/search")!

        let mock = Mock(url: URL(string: "https://api.mercadolibre.com/sites/MLB/search")!, ignoreQuery: true, contentType: .none, statusCode: 204, data: [.get: Data()])
        mock.register()

        let response = await session.request(url)
            .validate()
            .serializingDecodable(Data.self)
            .response

        let host = response.request?.url?.host
        let path = response.request?.url?.path
        let scheme = response.request?.url?.scheme

        #expect(scheme == "https")
        #expect(host == "api.mercadolibre.com")
        #expect(path == "/sites/MLB/search")
    }

    @Test("Testing if base URL is added to request and the query items are preserved")
    func testingBaseURLisAddedToRequestWithQuery() async throws {
        let url = URL(string: "/sites/MLB/search?limit=10&offset=0&q=Apple Watch")!

        let mock = Mock(url: URL(string: "https://api.mercadolibre.com/sites/MLB/search")!, ignoreQuery: true, contentType: .none, statusCode: 204, data: [.get: Data()])
        mock.register()

        let response = await session.request(url)
            .validate()
            .serializingDecodable(Data.self)
            .response

        guard let queryItems = URLComponents(url: response.request!.url!, resolvingAgainstBaseURL: false)?.queryItems else {
            Issue.record("Query items not found")
            return
        }

        let queryDict = Dictionary(uniqueKeysWithValues: queryItems.map { ($0.name, $0.value ?? "") })

        let host = response.request?.url?.host
        let path = response.request?.url?.path
        let scheme = response.request?.url?.scheme

        #expect(scheme == "https")
        #expect(host == "api.mercadolibre.com")
        #expect(path == "/sites/MLB/search")
        #expect(queryDict["q"] == "Apple Watch")
        #expect(queryDict["limit"] == "10")
        #expect(queryDict["offset"] == "0")
    }
}
