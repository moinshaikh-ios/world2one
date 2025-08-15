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
}

// MARK: - API Service
class APIService {
    static let shared = APIService()
    private init() {}
    
    private var activityIndicator: UIActivityIndicatorView?
    private var overlayView: UIView?
    private var activeRequests = 0


    // Show Loader with Non-Clickable Background
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

    func request<T: Decodable>(request: APIRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        let url = APIBaseUrl.baseURL + request.endpoint
        showLoader() // Show loader before making the request
        
        AF.request(url, method: HTTPMethod(rawValue: request.method.rawValue), parameters: request.parameters, encoding: request.encoding, headers: request.headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                self.hideLoader() // Hide loader once response is received
                
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    let apiError = self.handleError(response: response, error: error)
                    completion(.failure(apiError))
                }
            }
    }

    func upload(request: APIRequest, imageData: Data, completion: @escaping (Result<String, APIError>) -> Void) {
        let url = APIBaseUrl.baseURL + request.endpoint
        showLoader() // Show loader before uploading
        
        AF.upload(multipartFormData: { formData in
            formData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: request.headers)
        .validate()
        .responseString { response in
            self.hideLoader() // Hide loader once upload is complete
            
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                let apiError = self.handleError(response: response, error: error)
                completion(.failure(apiError))
            }
        }
    }
    
    private func handleError<T>(response: AFDataResponse<T>, error: AFError) -> APIError {
        if let statusCode = response.response?.statusCode {
            let errorMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            return .unknownError(errorMessage)
        }
        
        if let underlyingError = error.underlyingError as NSError?, underlyingError.domain == NSURLErrorDomain {
            return .networkError(underlyingError.localizedDescription)
        }
        
        return .unknownError(error.localizedDescription)
    }
}
