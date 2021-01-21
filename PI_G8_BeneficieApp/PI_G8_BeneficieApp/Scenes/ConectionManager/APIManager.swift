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
                        print(data)
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
                print(data)
                onComplete(true)

            case .failure(let error):
                onComplete(true)

            }
        }
    }
}
