//
//  SubscribeToActionViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation

class SubscribeToActionViewModel {
    
    var apiManager = APIManager()
    
    func subscribeUser(event: Event, onComplete: @escaping (Bool) -> Void) {
        apiManager.subscribeUserToEvent(event: event) { isOk in
            onComplete(isOk)
        }
    }
    
    // MARK: Database functions
    
//    var arrayTasks = [Task]()
    var dataBaseManager = DataBaseManager()
//
//
    func saveNewEventToDataBase(eventName: String, eventDate: String) {
        dataBaseManager.save(eventNameDB: eventName, eventDateDB: eventDate)
        loadSavedEvents()
//        loadSavedEvents()
    }

    func editEvent(event: CurrentEventDB, eventName: String, eventDate: String) {
        let id = event.objectID
        dataBaseManager.edit(id: id, eventNameDB: eventName, eventDateDB: eventDate)
//        loadSavedEvents()
    }

    func deleteEvent(event: CurrentEventDB) {
        let id = event.objectID
        dataBaseManager.delete(id: id)
//        loadSavedEvents()
    }

    func loadSavedEvents() {
        dataBaseManager.loadData { (arrayEvents) in
//            if let arrayEventsDB = arrayEvents {
//                self.arrayEvents = arrayEventsDB
//            }
        }
    }
    
    func getCoreDataDBPath() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print("Core Data DB Path :: \(path ?? "Not found")")
    }
    
    
}
