//
//  ServiceType.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

protocol ServiceType {
    var session: Session { get }

    func request<Request: RequestType>(_ request: Request, cache: CachedResponseHandler) async -> DataResponse<Request.Response, AFError>
}

extension ServiceType {
    func request<Request: RequestType>(_ request: Request, cache: CachedResponseHandler = .cache) async -> DataResponse<Request.Response, AFError> {
        await session
            .request(request)
            .cacheResponse(using: cache)
            .validate()
            .serializingDecodable(Request.Response.self)
            .response
    }
}
