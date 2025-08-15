//
//  MarchentDataModel.swift
//  World2One
//
//  Created by Moin on 01/03/2025.
//

import Foundation


// MARK: - Welcome
struct MarchentDataModel: Codable {
    let id: Int?
    let key, name, description, imageURL: String?
    let imageUrl1, phone, email: String?
    let website: String?
    let isLinked: Bool?
    let distance: Int?
    let address: Address?
    let offers: [Offer]?
    let onlineOnly: Bool?
    let mobileExternalLinkMessage: String?
    let isGroupSponsor: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case key = "Key"
        case name = "Name"
        case description = "Description"
        case imageURL = "ImageUrl"
        case imageUrl1 = "ImageUrl1"
        case phone = "Phone"
        case email = "Email"
        case website = "Website"
        case isLinked = "IsLinked"
        case distance = "Distance"
        case address = "Address"
        case offers = "Offers"
        case onlineOnly = "OnlineOnly"
        case mobileExternalLinkMessage = "MobileExternalLinkMessage"
        case isGroupSponsor = "IsGroupSponsor"
    }
}

