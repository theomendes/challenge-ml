//
//  InjectedValues+NetworkManager.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation

extension InjectedValues {
    var networkProvider: NetworkManagerType {
        get { Self[NetworkManagerKey.self] }
        set { Self[NetworkManagerKey.self] = newValue }
    }
}
