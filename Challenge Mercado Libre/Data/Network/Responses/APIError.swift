//
//  APIError.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 02/02/25.
//

struct APIError: Decodable, Error {
    let blockedBy: String
    let code: String
    let message: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case blockedBy = "blocked_by"
        case code, message, status
    }
}
