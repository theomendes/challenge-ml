//
//  NetworkManagerKey.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

struct NetworkManagerKey: InjectionKey {
    static var currentValue: NetworkManagerType = {
        let configuration = URLSessionConfiguration.default
        let retriers: [RequestInterceptor] = [
            .retryPolicy,
            .connectionLostRetryPolicy
        ]
        let adapters: [RequestInterceptor] = [
            BaseURLInterceptor(baseURL: URL(string: "https://api.mercadolibre.com/")!)
        ]
        let interceptor = Interceptor(adapters: adapters, retriers: retriers)
        let session = Session(configuration: configuration, interceptor: interceptor)
        return NetworkManager(session: session)
    }()
}
