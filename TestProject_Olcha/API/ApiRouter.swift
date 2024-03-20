//
//  ApiRouter.swift
//  Weather_App
//
//  Created by Sarvar Qosimov on 21/02/24.
//

import Alamofire
import CoreLocation

enum ApiRouter: URLRequestConvertible {
    case posts
    case user(id: Int)
    
    var path: String {
        switch self {
        case .posts: return URLS.POSTS
        case .user: return URLS.USER
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .posts: return .get
        case .user: return .get
        }
    }
    
    var querries: [String : Any]? {
        switch self {
        case .posts: return nil
        case .user(id: let id): return ["id" : id]
        }
    }
    
    var parametrs: Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: try path.asURL())
        
        request.httpMethod = method.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if querries != nil {
            request = try URLEncoding.queryString.encode(request, with: querries)
        }
        
        if let params = self.parametrs {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        return request
    }
}
