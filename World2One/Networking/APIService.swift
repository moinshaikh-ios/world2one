//
//  APIService.swift
//  World2One
//
//  Created by Moin on 10/02/2025.
//

import Foundation
import Alamofire
import UIKit

// MARK: - API BaseUrls
struct APIBaseUrl {
    static let baseURL = "https://api.world2one.com/"
    static let ImgUrl = "https://www.world2one.com/"
}

// MARK: - API Request Type
enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - API Request Protocol
protocol APIRequest {
    var endpoint: String { get }
    var method: HTTPMethodType { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

// MARK: - API Error Handling
enum APIError: Error {
    case networkError(String)
    case serverError(String)
    case decodingError(String)
    case unknownError(String)
    
    var message: String {
        switch self {
        case .networkError(let msg): return msg
        case .serverError(let msg): return msg
        case .decodingError(let msg): return msg
        case .unknownError(let msg): return msg
        }
    }
}

// MARK: - API Service
class APIService {
    static let shared = APIService()
    private init() {}
    
    private var activityIndicator: UIActivityIndicatorView?
    private var overlayView: UIView?
    private var activeRequests = 0
    
    // MARK: Loader
    private func showLoader() {
        DispatchQueue.main.async {
            self.activeRequests += 1
            if self.overlayView != nil { return } // Already showing
            
            if let window = UIApplication.shared.windows.first {
                let overlay = UIView(frame: window.bounds)
                overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                overlay.isUserInteractionEnabled = true
                
                let loader = UIActivityIndicatorView(style: .large)
                loader.center = window.center
                loader.color = .white
                loader.startAnimating()
                
                overlay.addSubview(loader)
                window.addSubview(overlay)
                
                self.overlayView = overlay
                self.activityIndicator = loader
            }
        }
    }
    
    private func hideLoader() {
        DispatchQueue.main.async {
            self.activeRequests -= 1
            if self.activeRequests > 0 { return } // Other requests still running
            
            self.activityIndicator?.stopAnimating()
            self.overlayView?.removeFromSuperview()
            self.activityIndicator = nil
            self.overlayView = nil
        }
    }
    
    // MARK: - Generic Request
    func request<T: Decodable>(request: APIRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        let url = APIBaseUrl.baseURL + request.endpoint
        showLoader()
        
        AF.request(url,
                   method: HTTPMethod(rawValue: request.method.rawValue),
                   parameters: request.parameters,
                   encoding: request.encoding,
                   headers: request.headers)
        .validate()
        .responseDecodable(of: T.self) { response in
            self.hideLoader()
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                let apiError = self.handleError(response: response, error: error)
                completion(.failure(apiError))
            }
        }
    }
    
    // MARK: - Upload
    func upload(request: APIRequest, imageData: Data, completion: @escaping (Result<String, APIError>) -> Void) {
        let url = APIBaseUrl.baseURL + request.endpoint
        showLoader()
        
        AF.upload(multipartFormData: { formData in
            formData.append(imageData,
                            withName: "file",
                            fileName: "image.jpg",
                            mimeType: "image/jpeg")
        }, to: url, method: .post, headers: request.headers)
        .validate()
        .responseString { response in
            self.hideLoader()
            
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                let apiError = self.handleError(response: response, error: error)
                completion(.failure(apiError))
            }
        }
    }
    
    // MARK: - Error Handling
    private func handleError<T>(response: AFDataResponse<T>, error: AFError) -> APIError {
        
        // 1️⃣ Parse backend JSON error message if any
        if let data = response.data {
            if let backendMessage = parseBackendError(data: data) {
                return .serverError(backendMessage)
            }
        }
        
        // 2️⃣ HTTP status codes
        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 400: return .serverError("Bad request. Please try again.")
            case 401: return .serverError("Unauthorized. Please log in again.")
            case 403: return .serverError("Access denied. You don’t have permission.")
            case 404: return .serverError("Requested resource not found.")
            case 500: return .serverError("Server error. Please try again later.")
            default:
                let errorMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                return .serverError(errorMessage)
            }
        }
        
        // 3️⃣ Network issues
        if let underlyingError = error.underlyingError as NSError?, underlyingError.domain == NSURLErrorDomain {
            switch underlyingError.code {
            case NSURLErrorNotConnectedToInternet:
                return .networkError("No internet connection. Please check your network and try again.")
            case NSURLErrorTimedOut:
                return .networkError("The request timed out. Please try again later.")
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
                return .networkError("We couldn’t reach the server. Please try again later.")
            case NSURLErrorSecureConnectionFailed, NSURLErrorServerCertificateUntrusted:
                return .networkError("Secure connection failed. Please update the app or try again later.")
            case NSURLErrorCancelled:
                return .networkError("The request was cancelled.")
            default:
                return .networkError(underlyingError.localizedDescription)
            }
        }
        
        // 4️⃣ Fallback
        return .unknownError(error.localizedDescription)
    }
    
    private func parseBackendError(data: Data) -> String? {
        // Common backend error formats
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let message = json["message"] as? String { return message }
            if let error = json["error"] as? String { return error }
            if let detail = json["detail"] as? String { return detail }
            if let errors = json["errors"] as? [String] { return errors.joined(separator: "\n") }
        }
        return nil
    }
}
