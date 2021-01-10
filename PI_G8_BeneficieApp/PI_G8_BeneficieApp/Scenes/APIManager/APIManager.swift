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
    
    func getAsArray(
        url: String,
        onSuccess: @escaping (_ responseArray: Data) -> Void,
        onFailure: @escaping (_ errorMessage: String?) -> Void
    ) {
        AF.request(url).response { response in
            
            switch response.result {
            case .success(let data):
                if let responseValue = response.data {
                    onSuccess(responseValue)
                    return
                }
                else {
                    onFailure("No response value")
                    return
                }
                
            case .failure(let error):
                onFailure(error.failureReason)
                
            }
        }
    }
    
    func subscribeUserToEvent(
        event: Event,
        onComplete: @escaping (_ isOk: Bool) -> Void
    ) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(event)
        
        let url = URL(string: "https://beneficie-app.herokuapp.com/beneficie/events/\(event._id)")!
        
        var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.put.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            AF.request(request).responseJSON { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    onComplete(true)
                    
                case .failure(let error):
                    onComplete(true)
                    
                }
            }
//        AF.request(, method: .put, parameters: event, encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
//
//            switch response.result {
//            case .success(let data):
//                print(data)
//                    onComplete(true)
//
//            case .failure(let error):
//                onComplete(true)
//
//            }
//        }
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
