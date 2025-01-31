//
//  MockSession.swift
//  Unit Tests
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation
import Mocker

final class MockSession {
    static func createMockSession(with interceptor: RequestInterceptor? = nil) -> Session {
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [MockingURLProtocol.self]

        return Session(configuration: configuration, interceptor: interceptor)
    }
}
