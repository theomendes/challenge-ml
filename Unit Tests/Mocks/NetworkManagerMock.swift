//
//  NetworkManagerMock.swift
//  Unit Tests
//
//  Created by Theo Mendes on 02/02/25.
//

import Alamofire
import Foundation
@testable import Challenge_Mercado_Libre

final class NetworkManagerMock: NetworkManagerType {
    private let session: Session

    init() {
        self.session = MockSession.createMockSession()
    }

    lazy var searchService: SearchServiceType = {
        SearchService(session: session)
    }()
}
