//
//  SearchUseCaseTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 02/02/25.
//

import Foundation
import Testing
import Mocker
@testable import Challenge_Mercado_Libre

@Suite("Search Use Case Tests")
struct SearchUseCaseTests {
    let searchService: SearchService
    let searchUseCase: SearchUseCase

    init() {
        searchService = SearchService(session: MockSession.createMockSession())
        searchUseCase = SearchUseCase(repository: SearchResultRepository(service: searchService))
    }

    @Test("Testing sucessful request")
    func testingConnectionError() async throws {
        mockNetworkError(URLError(.notConnectedToInternet))

        await #expect(throws: SearchError.internetConnection) {
            _ = try await searchUseCase.execute(for: "", on: "", category: nil, limit: 10, offset: 0)
        }

        mockNetworkError(URLError(.networkConnectionLost))

        await #expect(throws: SearchError.internetConnection) {
            _ = try await searchUseCase.execute(for: "", on: "", category: nil, limit: 10, offset: 0)
        }

        mockNetworkError(URLError(.timedOut))

        await #expect(throws: SearchError.internetConnection) {
            _ = try await searchUseCase.execute(for: "", on: "", category: nil, limit: 10, offset: 0)
        }
    }

    @Test("Testing custom error decoding")
    func testingCustomErrorDecoding() async throws {
        let url = URL(string: "/search")!
        let errorData = try Data(contentsOf: MockedData.custom403Error)
        let mock = Mock(url: url, ignoreQuery: true, contentType: .json, statusCode: 403, data: [.get: errorData])

        mock.register()

        do {
            _ = try await searchUseCase.execute(for: "", on: "", category: nil, limit: 10, offset: 0)
            Issue.record("Expected error but received success response")
        } catch let error as SearchError {
            switch error {
            case .serviceError(let code, let message):
                #expect(code == "PA_UNAUTHORIZED_RESULT_FROM_POLICIES", "Unexpected error code")
                #expect(message == "At least one policy returned UNAUTHORIZED.", "Unexpected error message")

            default:
                Issue.record("Expected `.serviceError`, but got \(error)")
            }
        } catch {
            Issue.record("Expected `SearchError`, but got \(error)")
        }
    }

    @Test("Testing unable to decode custom erro throws generic error")
    func testingUnableToDecodeCustomErrorThrowsGenericError() async throws {
        let url = URL(string: "/search")!
        let errorData = try Data(contentsOf: MockedData.decoding403Error)
        let mock = Mock(url: url, ignoreQuery: true, contentType: .json, statusCode: 403, data: [.get: errorData])

        mock.register()

        await #expect(throws: SearchError.generic) {
            _ = try await searchUseCase.execute(for: "", on: "", category: nil, limit: 10, offset: 0)
        }
    }

    @Test("Testing no results error")
    func testingNoResultsError() async throws {
        let url = URL(string: "/search")!
        let resultData = try Data(contentsOf: MockedData.searchServiceNoResult)
        let mock = Mock(url: url, ignoreQuery: true, contentType: .json, statusCode: 200, data: [.get: resultData])
        mock.register()

        await #expect(throws: SearchError.emptyResults(query: "sdaasdasdasdawdawsdwa")) {
            _ = try await searchUseCase.execute(for: "sdaasdasdasdawdawsdwa", on: "", category: nil, limit: 10, offset: 0)
        }
    }

    @Test("Testing success search")
    func testingSuccessSearch() async throws {
        let url = URL(string: "/search")!
        let resultData = try Data(contentsOf: MockedData.searchService)
        let mock = Mock(url: url, ignoreQuery: true, contentType: .json, statusCode: 200, data: [.get: resultData])
        mock.register()

        let sections = try await searchUseCase.execute(for: "Apple Watch", on: "", category: nil, limit: 10, offset: 0)

        #expect(sections.count == 1)
        #expect(sections.first?.items.count == 10)
        #expect(sections.first?.items.first?.id == "MLB5097135428")
        #expect(sections.first?.items.first?.price.formatedAmount == "R$ 5.499")
        dump(sections.first?.items.first?.price)
        #expect(sections.first?.items.first?.price.discountPercentage == 19)
    }

    private func mockNetworkError(_ error: URLError) {
        let url = URL(string: "/search")!
        let mock = Mock(url: url, ignoreQuery: true, contentType: .json, statusCode: 500, data: [
            .get: try! Data(contentsOf: MockedData.searchService)
        ], requestError: error)

        mock.register()
    }
}
