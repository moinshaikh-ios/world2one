//
//  Offers.swift
//  World2One
//
//  Created by Moin on 12/02/2025.
//

import Foundation


struct OffersDataModel: Codable {
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

// MARK: - Address
struct Address: Codable {
    let streetAddress1, streetAddress2, city, state: String?
    let zipCode: String?
    let longitude, latitude: Int?

    enum CodingKeys: String, CodingKey {
        case streetAddress1 = "StreetAddress1"
        case streetAddress2 = "StreetAddress2"
        case city = "City"
        case state = "State"
        case zipCode = "ZipCode"
        case longitude = "Longitude"
        case latitude = "Latitude"
    }
}

// MARK: - Offer
struct Offer: Codable {
    let key, name, description, terms: String?
    let startDate, endDate: String?
    let timeLeft, availableIn: Int?
    let isUsageLimited: Bool?
    let usageAvailable: Int?
    let isAvailableInFuture: Bool?
    let imageURL: String?
    let redeemURL: String?
    let merchant: String?
    let onlineOnly, isOffer, isNew: Bool?
    let isGroupSponsor: Bool?

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case name = "Name"
        case description = "Description"
        case terms = "Terms"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case timeLeft = "TimeLeft"
        case availableIn = "AvailableIn"
        case isUsageLimited = "IsUsageLimited"
        case usageAvailable = "UsageAvailable"
        case isAvailableInFuture = "IsAvailableInFuture"
        case imageURL = "ImageUrl"
        case redeemURL = "RedeemUrl"
        case merchant = "Merchant"
        case onlineOnly = "OnlineOnly"
        case isOffer = "IsOffer"
        case isNew = "IsNew"
        case isGroupSponsor = "IsGroupSponsor"
    }
}
