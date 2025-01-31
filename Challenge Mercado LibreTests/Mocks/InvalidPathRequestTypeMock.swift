//
//  InvalidPathRequestTypeMock.swift
//  Challenge Mercado LibreTests
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation
@testable import Challenge_Mercado_Libre

struct InvalidPathRequestTypeMock: RequestType {
    typealias Response = Data

    var path: String { "" }

    var method: Alamofire.HTTPMethod { .get }
}
