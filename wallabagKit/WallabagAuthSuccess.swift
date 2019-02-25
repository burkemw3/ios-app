//
//  WallabagAuthSuccess.swift
//  wallabagKit
//

import Foundation

public struct WallabagAuthSuccess: Codable {
    public let accessToken: String
    let expiresIn: Int
    public let refreshToken: String
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
}
