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
    var arraySubGroups = [Subgroup]()
    
    var apiManager = APIManager()
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
        apiManager.getAsArray(
            url: "https://beneficie-app.herokuapp.com/beneficie/events/") { (responseData) in
            
//            let jsonData = try Data(contentsOf: URL(fileURLWithPath:filePath), options: .alwaysMapped)

            let jsonDecoder = JSONDecoder()
            
            self.arrayEvents = try! jsonDecoder.decode(Array<Event>.self,from: responseData)
            
            onComplete(true)
        }
        onFailure: { (error) in
            print("Error \(error)")
            onComplete(false)
        }

//            (json, jsonArray, string) in
//                if let jsonArray = jsonArray {
//                    var events = [Event]()
//                    for item in jsonArray {
//                        events.append(Event(fromDictionary: item))
//                    }
//                    self.arrayEvents = events
//                    onComplete(true)
//                    return
//                }
//                onComplete(false)
//            }
        }
    
}
