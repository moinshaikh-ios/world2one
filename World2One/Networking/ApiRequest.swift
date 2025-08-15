//
//  ApiRequest.swift
//  World2One
//
//  Created by Moin on 10/02/2025.
//

import Foundation
import Alamofire


// MARK: - Login API Request
struct LoginRequest: APIRequest {
    var endpoint: String = "login"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders? = ["Content-Type": "application/x-www-form-urlencoded"]
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(email: String, password: String) {
        self.parameters = ["Username": email, "Password": password]
    }
}

// MARK: - Register API Request
struct RegisterRequest: APIRequest {
    var endpoint: String = "register"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders? = ["Content-Type": "application/x-www-form-urlencoded"]
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(Username:String, Password:String, ConfirmPassword:String,AutoCreate:String) {
        if AutoCreate == "" {
            self.parameters = ["Username": Username, "Password": Password, "ConfirmPassword":ConfirmPassword]
        }else {
            self.parameters = ["AutoCreate":"true"]
        }
        
    }
}

// MARK: - Offers API Request
struct OffersRequest: APIRequest {
    var endpoint: String = "offers"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(PageNumber: Int, PageSize: Int, token: String) {
        if AppDefault.filterId == [] && AppDefault.groupId == [] {
            self.parameters = ["PageNumber": PageNumber, "PageSize": PageSize, "SortColumn": "ProductName" , "SortDirection": "ASC"]
        }else if AppDefault.filterId == [] && AppDefault.groupId != []{
            let resultArray = [AppDefault.groupId.joined(separator: ",")]
            self.parameters = ["PageNumber": PageNumber, "PageSize": PageSize,"GroupIDs": resultArray]
        }else if AppDefault.filterId != [] && AppDefault.groupId == []{
            self.parameters = ["PageNumber": PageNumber, "PageSize": PageSize,"FilterIds":[AppDefault.filterId]]
        }else {
            self.parameters = ["PageNumber": PageNumber, "PageSize": PageSize,"FilterIds":[AppDefault.filterId],"GroupIDs": [AppDefault.groupId]]
        }
        if token == "" {
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded",
//                "Authorization": "OAuth f672cfc6c48744c188f44ba012ce9eb2"
            ]
        }else {
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "OAuth \(token)"
            ]
        }

    }
}

// MARK: - OffersDetail API Request
struct OffersDetailRequest: APIRequest {
    var endpoint: String = "offer"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(Key: String, token: String) {
        self.parameters = ["Key": Key]
        self.headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "OAuth \(token)"
        ]
    }
}

// MARK: - FilterMenuRequest API Request
struct FilterMenuRequest: APIRequest {
    var endpoint: String = "menu"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(token: String) {
        if token == "" {
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded",
//                "Authorization": "OAuth f672cfc6c48744c188f44ba012ce9eb2"
            ]
        }else {
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "OAuth \(token)"
            ]
        }
    }
}

// MARK: - GroupRemoveRequest API Request
struct GroupRemoveRequest: APIRequest {
    var endpoint: String = "group"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(id:String, token: String) {
        self.parameters = ["Id":id]
        self.headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "OAuth \(token)"
        ]
    }
}

// MARK: - MarchentRequest API Request
struct MarchentRequest: APIRequest {
    var endpoint: String = "biz"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(Key:String, token: String) {
        self.parameters = ["Key":Key]
        self.headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "OAuth \(token)"
        ]
    }
}

// MARK: - MarchentAddandRemoveRequest API Request
struct MarchentAddandRemoveRequest: APIRequest {
    var endpoint: String = "userbiz"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(Key:String, token: String,add:String,remove:String) {
        if add == "" {
            self.parameters = ["key":Key,"remove":"true"]
        }else {
            self.parameters = ["key":Key,"add":"true"]
        }
//        self.parameters = ["Key":Key]
        self.headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "OAuth \(token)"
        ]
    }
}

// MARK: - MarchentAddandRemoveRequest API Request
struct redeemRequest: APIRequest {
    var endpoint: String = "redeem"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(key:String, token: String) {
        self.parameters = ["Key":key]
        self.headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "OAuth \(token)"
        ]
    }
}

// MARK: - MarchentAddandRemoveRequest API Request
struct deviceRequest: APIRequest {
    var endpoint: String = "device"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(PushRegistrationId:String){
        self.parameters = ["ClientID":"4", 
                           "Key":"AIzaSyAqf82eRuTbB7x6WRoN8UdTGJlrMslDB5M",
                           "PushRegistrationId":PushRegistrationId,
                           "OSVersion":"ios",
                           "OSVersionNumber":"",
                           "Model":"",
                           "ApplicationVersion":"",
                           "TimeZone": "",
                           "TimeZoneOffset":""]
        self.headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "OAuth 9d50d286058b4406a3c3d3a63e569589"
        ]
    }
}

struct deepLinkRequest: APIRequest {
    var endpoint: String = "deeplink"
    var method: HTTPMethodType = .post
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(LinkPath:String){
        self.parameters = ["LinkPath":LinkPath]
        if AppDefault.accessToken == "" {
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded",
    //            "Authorization": "OAuth 9d50d286058b4406a3c3d3a63e569589"
            ]
        }else {
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "OAuth \(AppDefault.accessToken)"
            ]
        }

    }
}


// MARK: - API Manager
class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<LoginModel, APIError>) -> Void) {
        let request = LoginRequest(email: email, password: password)
        APIService.shared.request(request: request, completion: completion)
    }
    
    func register(Username:String, Password:String, ConfirmPassword:String,AutoCreate:String, completion: @escaping (Result<RegisterDataModel, APIError>) -> Void) {
        let request = RegisterRequest(Username: Username, Password: Password, ConfirmPassword: ConfirmPassword, AutoCreate: AutoCreate)
        APIService.shared.request(request: request, completion: completion)
    }
    
    func Offers(PageNumber:Int, PageSize:Int, token:String ,completion: @escaping (Result<[OffersDataModel], APIError>) -> Void) {
        let request = OffersRequest(PageNumber: PageNumber, PageSize: PageSize, token: token)
        APIService.shared.request(request: request, completion: completion)
    }
    
    func OffersDetail(Key:String, token:String ,completion: @escaping (Result<OfferDetailModel, APIError>) -> Void) {
        let request = OffersDetailRequest(Key: Key, token: token)
        APIService.shared.request(request: request, completion: completion)
    }
    
    
    func FilterMenu(token:String ,completion: @escaping (Result<[FilterDataModel], APIError>) -> Void) {
        let request = FilterMenuRequest(token: token)
        APIService.shared.request(request: request, completion: completion)
    }
    
    func GroupRemove(id:String, token:String ,completion: @escaping (Result<groupRemoveDataModel, APIError>) -> Void) {
        let request = GroupRemoveRequest(id: id, token: token)
        APIService.shared.request(request: request, completion: completion)
    }
    
    func Marchent(Key:String, token:String ,completion: @escaping (Result<MarchentDataModel, APIError>) -> Void) {
        let request = MarchentRequest(Key: Key, token: token)
        APIService.shared.request(request: request, completion: completion)
    }
    
    func MarchentAddandRemove(Key:String, token:String, add:String,remove:String ,completion: @escaping (Result<groupRemoveDataModel, APIError>) -> Void) {
        let request = MarchentAddandRemoveRequest(Key: Key, token: token, add: add, remove: remove)
        APIService.shared.request(request: request, completion: completion)
    }
    
    func redeem(Key:String, token:String,completion: @escaping (Result<groupRemoveDataModel, APIError>) -> Void) {
        let request = redeemRequest(key: Key, token: token)
        APIService.shared.request(request: request, completion: completion)
    }
    
    func device(PushRegistrationId:String,completion: @escaping (Result<groupRemoveDataModel, APIError>) -> Void) {
        let request = deviceRequest(PushRegistrationId: PushRegistrationId)
        APIService.shared.request(request: request, completion: completion)
    }
    func deepLink(LinkPath:String,completion: @escaping (Result<groupRemoveDataModel, APIError>) -> Void) {
        let request = deepLinkRequest(LinkPath: LinkPath)
        APIService.shared.request(request: request, completion: completion)
    }
    
}
