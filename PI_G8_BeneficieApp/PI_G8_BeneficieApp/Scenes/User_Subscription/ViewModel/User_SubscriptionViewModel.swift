//
//  User_SubscriptionViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation

class User_SubscriptionViewModel {
    
    var arrayEvents = [Event]()
    var arraySubGroups = [String]()
    
    var apiManager = APIManager()
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
        apiManager.requestArray(
            url: "https://beneficie-app.herokuapp.com/beneficie/events/") { (responseArray) in
            print("Success \(responseArray)")
            onComplete(true)
        } onFailure: { (error) in
            print("Error \(error)")
            onComplete(false)
        }

            
            
//            (json, jsonArray, string) in
//                if let jsonArray = jsonArray {
//                    var events = [Event]()
//                    var groups = [String]()
//                    for item in jsonArray {
//                        events.append(Event(fromDictionary: item))
//                    }
//                    for event in 1...events.count {
//                        var count = 0
//                        groups.append("\(count + 1)")
//                    }
//                    self.arrayEvents = events
//                    self.arraySubGroups = groups
//                    onComplete(true)
//                    return
//                }
//                onComplete(false)
//            }
        }
    
}
