//
//  FilterDataModel.swift
//  World2One
//
//  Created by Moin on 18/02/2025.
//

import Foundation

struct FilterDataModel: Codable {
    let filterType: Int?
    let itemType: Int?
    let title: String?
    let value: String?
    let icon: Int?
    let count: Int?
    let isCounterVisible: Bool?
    let selected: Bool?
    let isParentCategory: Bool?
}


// MARK: - groupRemove DataModel
struct groupRemoveDataModel: Codable {
    let result: Bool?
    let resultCode, resultDescription, resultAction: String?
    let resultCount: Int?
    let modelList: [LoginModel]?
}


// MARK: - ModelList
struct ModelList: Codable {
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
