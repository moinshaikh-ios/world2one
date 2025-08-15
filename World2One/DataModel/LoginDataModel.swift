//
//  LoginDataModel.swift
//  World2One
//
//  Created by Moin on 10/02/2025.
//

import Foundation


// MARK: - Welcome
struct LoginModel: Codable {
    let activity, bundleName, bundleContent, linkPath: String?
        let accessToken: String?
        let expiresIn: Int?
        let refreshToken: String?
        let success: Bool?
        let username: String?
        let autoCreated: Bool?
        let id: Int?

        enum CodingKeys: String, CodingKey {
            case activity, bundleName, bundleContent, linkPath
            case accessToken = "access_token"
            case expiresIn = "expires_in"
            case refreshToken = "refresh_token"
            case success, username
            case autoCreated = "auto_created"
            case id
        }
}



