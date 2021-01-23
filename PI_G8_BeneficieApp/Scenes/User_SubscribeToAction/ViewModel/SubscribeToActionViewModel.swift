//
//  SubscribeToActionViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
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
    func saveNewEventToDataBase(eventName: String, eventDate: String, eventAddress: String, eventDescription: String, eventSubgroup: String) {
        dataBaseManager.save(eventName: eventName, eventDate: eventDate, eventAddress: eventAddress, eventDescription: eventDescription, eventSubgroup: eventSubgroup)
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
            print(arrayEvents)
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
