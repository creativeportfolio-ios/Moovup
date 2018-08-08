//
//  NetworkManager.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import Foundation

import BrightFutures
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import RappleProgressHUD

enum NetworkError: Error {
    case notFound
    case unauthorized
    case forbidden
    case nonRecoverable
    case errorString(String?)
    case unprocessableEntity(String?)
    case other
}

struct NetworkManager {
    
    static let networkQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier ?? "com.moovup").networking-queue", attributes: .concurrent)
    
    static func makeJSONObjectArrayRequest(_ urlRequest: URLRequestConvertible,  message: String, showProgress: Bool) -> Future<[Dictionary<String, Any>], NetworkError> {
        let promise = Promise<[Dictionary<String, Any>], NetworkError>()
        
        DispatchQueue.main.async() {
            if (showProgress == true) {
                let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.apple)
                if message != "" {
                    RappleActivityIndicatorView.startAnimatingWithLabel(message, attributes: attributes)
                }
                else{
                    RappleActivityIndicatorView.startAnimating(attributes: attributes)
                }
            }
        }
        
        let request = Alamofire.request(urlRequest)
            .validate()
            .responseJSON(queue: networkQueue) { response in
                print(response.result)
                if (showProgress == true) {
                    DispatchQueue.main.async() {
                        RappleActivityIndicatorView.stopAnimation()
                    }
                }
                switch response.result {
                case .success(let JSON):
                    if let jsonObject = JSON as? [Dictionary<String, Any>] {
                        promise.success(jsonObject)
                    }
                    else {
                        promise.failure(.other)
                    }
                case .failure
                    where response.response?.statusCode == 401:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 403:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 404:
                    promise.failure(.notFound)
                case .failure
                    where response.response?.statusCode == 500:
                    promise.failure(.nonRecoverable)
                case .failure:
                    promise.failure(.other)
                }
        }
        debugPrint(request)
        return promise.future
    }
}
