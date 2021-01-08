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
        apiManager.requestArray(
            url: "https://beneficie-app.herokuapp.com/beneficie/events/") { (responseArray) in
            var events = [Event]()
            for item in responseArray {
                events.append(Event(fromDictionary: item as! [String : Any]))
            }
            self.arrayEvents = events
            onComplete(true)
            return
                onComplete(true)
        }
        onFailure: { (error) in
            print("Error \(error)")
            onComplete(false)
        }
    }
}
