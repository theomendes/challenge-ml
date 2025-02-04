//
//  DeepLinkTests.swift
//  Unit Tests
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation
import Testing
@testable import Challenge_Mercado_Libre

@Suite("Deep Link Tests")
struct DeepLinkTests {

    @Test("Test deep link with mapped route - search")
    func testingDeepLinkWithSuccessfulRoute() async throws {
        let url = URL(string: "challenge-ml://search?q=Apple%20Watch&siteId=MLB&category=MLB135384")!
        let deepLink = DeepLink(url: url)

        switch deepLink {
        case .search(let query, let siteId, let category):
            #expect(query == "Apple Watch")
            #expect(siteId == "MLB")
            #expect(category == "MLB135384")
        default:
            Issue.record("Failed to parse deep link correctly")
        }
    }

    @Test("Test deep link with mapped route - search - missing category")
    func testingDeepLinkWithSuccessfulRouteMissingCategory() async throws {
        let url = URL(string: "challenge-ml://search?q=Apple%20Watch&siteId=MLB")!
        let deepLink = DeepLink(url: url)

        switch deepLink {
        case .search(let query, let siteId, let category):
            #expect(query == "Apple Watch")
            #expect(siteId == "MLB")
            #expect(category == nil)
        default:
            Issue.record("Failed to parse deep link correctly")
        }
    }

    @Test("Test deep link with missing query")
    func testingDeepLinkWithMissingQuery() async throws {
        let url = URL(string: "challenge-ml://search?siteId=MLB")!
        let deepLink = DeepLink(url: url)
        
        #expect(deepLink == nil)
    }

    @Test("Test deep link with missing site ID")
    func testingDeepLinkWithMissingSiteId() async throws {
        let url = URL(string: "challenge-ml://search?q=Apple%20Watch")!
        let deepLink = DeepLink(url: url)

        #expect(deepLink == nil)
    }

    @Test("Test deep link with invalid route")
    func testingDeepLinkWithInvalidRoute() async throws {
        let url = URL(string: "challenge-ml://product?id=MLB5097135428")!
        let deepLink = DeepLink(url: url)

        #expect(deepLink == nil)
    }
}
