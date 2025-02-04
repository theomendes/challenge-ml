//
//  DefaultValuesRequestTypeMock.swift
//  Unit Tests
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation
@testable import Challenge_Mercado_Libre

struct DefaultValuesRequestTypeMock: RequestType {
    typealias Response = Data

    var path: String { "mock" }

    var method: HTTPMethod { .get }
}
