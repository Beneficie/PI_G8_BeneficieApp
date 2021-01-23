//
//  User_EventViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation

class User_EventViewModel {
    
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
    
    // MARK: Data Base functions
    var dataBaseManager = DataBaseManager()
    var currentEvent = [CurrentEventDB]()
    
    func loadFromDataBase() -> [CurrentEventDB?] {
        dataBaseManager.loadData { (events) in
            if let currentEvents = events {
//                print(currentEvents)
                self.currentEvent = currentEvents
                print(self.currentEvent)
//                getCoreDataDBPath()
            }
        }
        return self.currentEvent
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
