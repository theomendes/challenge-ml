//
//  RequestTypeMock.swift
//  Challenge Mercado LibreTests
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation
@testable import Challenge_Mercado_Libre

struct RequestTypeMock: RequestType {
    typealias Response = Data

    var path: String { "mock" }

    var method: HTTPMethod { .get }

    let parameters: APIParameters

    init(parameters: APIParameters) {
        self.parameters = parameters
    }
}
