//
//  APIManager.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 21/12/20.
//

import Foundation
import Alamofire

class APIManager {
    
    // MARK: - Request URL and save response as array
    func getAsArray(
        url: String,
        onSuccess: @escaping (_ responseArray: Data) -> Void,
        onFailure: @escaping (_ errorMessage: String?) -> Void
    ) {
        AF.request(url).validate().response { response in
            
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
        
        if let eventId = event._id {
            let url = URL(string: "https://beneficie-app.herokuapp.com/beneficie/events/\(eventId)")!
        
            var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.put.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData

                AF.request(request).responseJSON { response in
                    switch response.result {
                    case .success(let data):
//                        print(data)
                        onComplete(true)
                        
                    case .failure(let error):
                        onComplete(true)
                    }
                }
            }
    }
    
    func createEvent(
        event: Event,
        onComplete: @escaping (_ isOk: Bool) -> Void
    ) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(event)

        let url = URL(string: "https://beneficie-app.herokuapp.com/beneficie/events")!

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        AF.request(request).responseJSON { response in
            switch response.result {
            case .success(let data):
//                print(data)
                onComplete(true)

            case .failure(let error):
                onComplete(true)

            }
        }
    }
    
    func requestUser(
        userToken: String,
        onComplete: @escaping (_ user: Data?, _ erro: String?) -> Void
    ) {
//        let encoder = JSONEncoder()
//        let jsonData = try! encoder.encode(event)
//
        let url = URL(string: "https://beneficie-app.herokuapp.com/beneficie/users/authenticate")!

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(userToken, forHTTPHeaderField: "firebaseauth")

        AF.request(request).validate().response { response in
            switch response.result {
            case .success(let data):
                if let responseValue = response.data {
//                    print(responseValue)
                    onComplete(responseValue, nil)
                } else {
                    onComplete(nil, "Received Empty Response")
                }
            case .failure(let error):
                onComplete(nil, error.failureReason)
                
            }
        }
    }
    
    func updateUserInformation(
        user: User,
        onComplete: @escaping (_ isOk: Bool) -> Void
    ) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(user)
        
        let userId = user._id
        let url = URL(string: "https://beneficie-app.herokuapp.com/beneficie/users/\(userId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        AF.request(request).validate().response { response in
            switch response.result {
            case .success(let data):
                print(data)
                onComplete(true)
                
            case .failure(let error):
                onComplete(true)
                print (error)
            }
        }
    }
}
