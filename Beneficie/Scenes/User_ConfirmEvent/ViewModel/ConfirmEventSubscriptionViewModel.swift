//
//  ConfirmEventSubscriptionViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import UIKit

class ConfirmEventSubscriptionViewModel {
    
    var apiManager = APIManager()
    var currentEvent = Event()
    var currentUser = User()
    var currentSubgroup = Subgroup()
    
    
    func subscribeUser(userToken: String, event: Event, subgroup: Subgroup, onComplete: @escaping (Bool) -> Void) {
        apiManager.subscribeUserToEvent(userToken: userToken, event: event, subgroup: subgroup) { isOk in
            onComplete(isOk)
        }
    }
    
    func isUserUpdated(name: String, phoneNumber: String) -> Bool {
        if currentUser.name != name && currentUser.phoneNumber != phoneNumber {
            currentUser.name = name
            currentUser.phoneNumber = phoneNumber
            return false
        } else {
            return true
        }
    }
        
    func updateUser(onComplete: @escaping (Bool) -> Void) {
        apiManager.updateUserInformation(user: currentUser) { isOk in
            onComplete(isOk)
        }
    }
    
    func setupValues(_ currentEvent: Event, _ currentUser: User, _ currentSubgroup: Subgroup) {
        self.currentEvent = currentEvent
        self.currentUser = currentUser
        self.currentSubgroup = currentSubgroup
    }
    
    func checkUser(name: String, phoneNumber: String) {
        if !isUserUpdated(name: name, phoneNumber: phoneNumber) {
            updateUser { (success) in
                if success {
                    print("user updated")
                }
            }
        } else {
            print("user NOT updated")
        }
        
    }
    
    func newRootController() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "User_Event", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "User_Event") as! User_EventViewController
        let navi = UINavigationController()
        navi.pushViewController(viewController, animated: true)
        UIViewController.replaceRootViewController(viewController: navi)
        navi.setNavigationBarHidden(true, animated: false)
    }
    
    func goToProfileScreen(user: User, navigationController: UINavigationController?) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            profile.currentUser = user
            navigationController?.pushViewController(profile, animated: true) }
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
//            print(arrayEvents)
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
