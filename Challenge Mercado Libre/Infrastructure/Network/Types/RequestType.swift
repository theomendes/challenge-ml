//
//  RequestType.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

protocol RequestType: URLRequestConvertible {
    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: APIParameters { get }
    var headers: HTTPHeaders { get }
}

// MARK: - Default implementation

extension RequestType {
    public var parameters: APIParameters {
        .plain
    }
    
    public var headers: HTTPHeaders {
        HTTPHeaders([
            .contentType("application/json")
        ])
    }

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: path) else {
            throw RequestTypeError.unableToCreateURLRequest
        }

        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers

        switch parameters {
        case .plain:
            return request
        case .parameters(let parameters, let encoding):
            return try encoding.encode(request, with: parameters)
        }
    }
}
