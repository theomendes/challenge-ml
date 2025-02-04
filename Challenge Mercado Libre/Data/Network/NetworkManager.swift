//
//  NetworkManager.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Alamofire
import Foundation

protocol NetworkManagerType {
    var searchService: SearchServiceType { get }
}

final class NetworkManager: NetworkManagerType {
    private let session: Session

    init(session: Session) {
        self.session = session
    }

    lazy var searchService: SearchServiceType = {
        SearchService(session: session)
    }()
}
