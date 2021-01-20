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
            url: "https://beneficie-app.herokuapp.com/beneficie/events/") { (responseData) in

            let jsonDecoder = JSONDecoder()
            
            self.arrayEvents = try! jsonDecoder.decode(Array<Event>.self,from: responseData)
            
            onComplete(true)
        }
        onFailure: { (error) in
            print("Error \(error)")
            onComplete(false)
        }
    }
    
    // MARK: Database functions
    
//    var arrayTasks = [Task]()
    var dataBaseManager = DataBaseManager()
//
//
    func saveNewEvent(eventName: String, eventDate: String) {
        dataBaseManager.save(eventNameDB: eventName, eventDateDB: eventDate)
        loadSavedEvents()
    }

    func editEvent(event: CurrentEventDB, eventName: String, eventDate: String) {
        let id = event.objectID
        dataBaseManager.edit(id: id, eventNameDB: eventName, eventDateDB: eventDate)
        loadSavedEvents()
    }

    func deleteEvent(event: CurrentEventDB) {
        let id = event.objectID
        dataBaseManager.delete(id: id)
        loadSavedEvents()
    }

    func loadSavedEvents() {
        dataBaseManager.loadData { (arrayEvents) in
//            if let arrayEventsDB = arrayEvents {
//                self.arrayEvents = arrayEventsDB
//            }
        }
    }
}
