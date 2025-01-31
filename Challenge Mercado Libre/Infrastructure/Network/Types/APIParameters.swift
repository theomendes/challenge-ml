//
//  APIParameters.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

enum APIParameters: Sendable {
    case plain
    case parameters(parameters: Alamofire.Parameters, encoding: ParameterEncoding)
}
