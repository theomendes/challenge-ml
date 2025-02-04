//
//  BaseURLInterceptor.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

final class BaseURLInterceptor: RequestInterceptor {
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let url = urlRequest.url else {
            completion(.success(urlRequest))
            return
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        let baseComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.scheme = baseComponents?.scheme
        components?.host = baseComponents?.host
        components?.path = baseURL.appendingPathComponent(url.path).path

        guard let adaptedURL = components?.url else {
            completion(.failure(AFError.invalidURL(url: url)))
            return
        }

        var request = urlRequest
        request.url = adaptedURL

        completion(.success(request))
    }
}
