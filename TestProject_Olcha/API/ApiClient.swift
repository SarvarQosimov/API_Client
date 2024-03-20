//
//  ApiClient.swift
//  Weather_App
//
//  Created by Sarvar Qosimov on 24/02/24.
//

import Foundation
import Alamofire

class ApiClient {

    @discardableResult
    static func performRequest<T: Codable>(route: ApiRouter, completion: @escaping ((T?) -> Void)) -> DataRequest {
        return AF.request(route)
            .responseDecodable(decoder: JSONDecoder()) { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let model):
                    completion(model)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
    }
    
    static func getPosts(completion: @escaping(PostModelList?)-> Void ){
        performRequest(route: ApiRouter.posts, completion: completion)
    }
    
    static func getUser(userID: Int, completion: @escaping(UserModelList?)-> Void ){
        performRequest(route: ApiRouter.user(id: userID), completion: completion)
    }
    
}
