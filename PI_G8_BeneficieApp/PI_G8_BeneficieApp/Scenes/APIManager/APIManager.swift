//
//  APIManager.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 21/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    func requestArray(
        url: String,
        onSuccess: @escaping (_ responseArray: [Any]) -> Void,
        onFailure: @escaping (_ errorMessage: String?) -> Void
    ) {
        AF.request(url).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                guard let responseValue = response.value else {
                    onFailure("No response value")
                    return
                }
                
                if let jsonArray = responseValue as? [Any] {
                    onSuccess(jsonArray)
                    print(data)
                } else {
                    onFailure("Failed to parse into [Any]")
                }
                
            case .failure(let error):
                onFailure(error.failureReason)
                
            }
        }
    }
    
//    func request(url: String, completion: @escaping (_ json: [String: Any]?, _ jsonArray: [[String: Any]]?, _ error: String?) -> Void) {
//
//        AF.request(url).responseJSON { response in
//
//            switch response.result {
//            case .success(let data): print("Success")
//            case .failure(let error): print("Request failed \(error)")
//            }
//
//            guard let jsonObj = response.value else {
//                completion(nil, nil, "")
//                return
//            }
//
////            dic
//            if let json = jsonObj as? [String: Any] {
//                if let jsn = json["error"] as? [String:Any] {
//                    completion(nil, nil, "")
//                } else {
//                    completion(json, nil, nil)
//                }
//
////             dic array
//            } else if let jsonArray = jsonObj as? [[String: Any]] {
//                completion(nil, jsonArray, nil)
//            } else {
//                completion(nil, nil, "")
//            }
//        }
//    }
}
