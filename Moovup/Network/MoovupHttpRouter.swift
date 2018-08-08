//
//  MoovupHttpRouter.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public enum MoovupHttpRouter: URLRequestConvertible {
    case getUserList()
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getUserList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getUserList:
            return "get/cfdlYqzrfS"
        }
    }
    
    var urlParameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var headerField: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL.init(string: Constant.baseURL()+path)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.allHTTPHeaderFields = headerField
        
        switch self {
        case .getUserList:
            return try URLEncoding.queryString.encode(urlRequest, with: self.urlParameters)
        }
    }
}
