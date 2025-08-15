//
//  RegisterDataModel.swift
//  World2One
//
//  Created by Moin on 10/02/2025.
//

import Foundation


// MARK: - Register Model
struct RegisterDataModel: Codable {
    let success: Bool?
    let message: String?
    let registerData: LoginModel?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case registerData = "Data"
    }
}

