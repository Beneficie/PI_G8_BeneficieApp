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
    
    // MARK: API Request
    var apiManager = APIManager()
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
        apiManager.getAsArray(
            url: "https://beneficie-app.herokuapp.com/beneficie/events1/") { (responseData) in

            let jsonDecoder = JSONDecoder()
            
            self.arrayEvents = try! jsonDecoder.decode(Array<Event>.self,from: responseData)
            
            onComplete(true)
        }
        onFailure: { (error) in
            print("Error \(error)")
            onComplete(false)
        }
    }
    
    // MARK: Data Base functions
    var dataBaseManager = DataBaseManager()
    var currentEvent = [CurrentEventDB]()
    
    func loadFromDataBase() -> [CurrentEventDB] {
        dataBaseManager.loadData { (events) in
            if let currentEvents = events {
                print(currentEvents)
                self.currentEvent = currentEvents
            }
        }
        return self.currentEvent
    }
}
