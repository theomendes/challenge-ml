//
//  InjectionKey.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import Foundation

public protocol InjectionKey {
    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Self.Value { get set }
}
