//
//  UserDefault.swift
//  World2One
//
//  Created by Moin on 12/02/2025.
//


import Foundation
import UIKit

extension UserDefaults {
    func decode<T : Codable>(for type: T.Type, using key : String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        return try? PropertyListDecoder().decode(type, from: data)
    }
    
    func encode<T : Codable>(for type: T?, using key : String) {
        let encodedData = try? PropertyListEncoder().encode(type)
        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
class AppDefault {
    
    static let shared = UserDefaults.standard
    
    //MARK:- Reset UserDefault
    public static func resetUserDefault(){
        let dictionary = shared.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            
            //FIXME: I omit deleting of following keys.
            if (key == "fcmToken" ||
                key == "deviceToken" ||
                key == "email" ||
                key == "password"
                ) {
                //Don't Remove These keys
            }else {
                shared.removeObject(forKey: key)
            }
        }
        print("UserDefault: \(shared.dictionaryRepresentation())")
    }
    
        public static var accessToken: String {
            get {
                return shared.string(forKey: "token") ?? ""
            }
            set {
                shared.set(newValue, forKey: "token")
            }
        }
    
    public static var username: String {
        get {
            return shared.string(forKey: "username") ?? ""
        }
        set {
            shared.set(newValue, forKey: "username")
        }
    }
    
    
        public static var filterId: [String] {
            get {
                return shared.stringArray(forKey: "filterId") ?? []
            }
            set {
                shared.set(newValue, forKey: "filterId")
            }
        }
    
    public static var groupId: [String] {
        get {
            return shared.stringArray(forKey: "groupId") ?? []
        }
        set {
            shared.set(newValue, forKey: "groupId")
        }
    }

    
    public static var currentUser: LoginModel? {
        get{
            return shared.decode(for: LoginModel.self, using: "CurrentUser")
        }
        set{
            shared.encode(for: newValue, using: "CurrentUser")
        }
    } 
    
    public static var filterArray2: [FilterDataModel] {
        get{
            return shared.decode(for: [FilterDataModel].self, using: "filterArray2") ?? []
        }
        set{
            shared.encode(for: newValue, using: "filterArray2")
        }
    }

    
    
}
