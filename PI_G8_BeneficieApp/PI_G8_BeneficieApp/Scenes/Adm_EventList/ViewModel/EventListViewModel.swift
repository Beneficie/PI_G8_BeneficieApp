//
//  EventListViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 18/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation

class EventListViewModel {
    
    var arrayEvents = [Event]()
    
    var apiManager = APIManager()
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
        apiManager.request(url: "https://beneficie-app.herokuapp.com/beneficie/events") { (json, jsonArray, string) in
            if let jsonArray = jsonArray {
                var events = [Event]()
                for item in jsonArray {
                    events.append(Event(fromDictionary: item))
                }
                self.arrayEvents = events
                onComplete(true)
                return
            }
            onComplete(false)
        }
    }
    
}
