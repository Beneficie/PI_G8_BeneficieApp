//
//  User_EventViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import FirebaseAuth

class User_EventViewModel {
    
    var arrayEvents = [Event]()
    var arraySubGroups = [Subgroup]()
    var userToken = ""
    var currentEvent = Event()
    var currentUser = User()
    var connectionReachable = Bool()
    var subgroup = ""
    
    // MARK: - API Request for Event
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
    
    // MARK: - API Request for User
    
    func getUserToken() {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { (idToken, error) in
            if error != nil {
//                todo logout user to main screen
                return
            }
            self.userToken = idToken!
            
            self.loadUserData()
        }
    }
    
    func loadUserData() {
        apiManager.requestUser(userToken: self.userToken, onComplete: { response, e in
//            print(self.userToken)
            if response == nil {
                return
            }
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: response!)
                self.currentUser.uid = user.uid
                self.currentUser._id = user._id
                self.currentUser.name = user.name
                self.currentUser.email = user.email
                self.currentUser.phoneNumber = user.phoneNumber
                return
            }
            catch {
                print(error)
            }
        }
        )}
    
    
    // MARK: Data Base functions
    var dataBaseManager = DataBaseManager()
    var currentEventDB = [CurrentEventDB]()
    
    func loadFromDataBase() -> [CurrentEventDB?] {
        dataBaseManager.loadData { (events) in
            if let currentEvents = events {
//                print(currentEvents)
                self.currentEventDB = currentEvents
//                print(self.currentEventDB)
//                getCoreDataDBPath()
            }
        }
        return self.currentEventDB
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
    
    func changeSubgroup() {
//        let alert = UIAlertController(title: "Você já se inscreveu", message: "Deseja Trocar subgrupo?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: {_ in
//            if let userSubscribe = UIStoryboard(name: "ConfirmEventSubscription", bundle: nil).instantiateInitialViewController() as? ConfirmEventSubscriptionViewController {
//
//                self.nextViewModel.currentEvent = self.viewModel.currentEvent
//                self.nextViewModel.currentSubgroup = self.viewModel.subgroup
//                self.nextViewModel.currentUser = self.viewModel.currentUser
//
//                self.navigationController?.pushViewController(userSubscribe, animated: true)
//            }
//        }))
//        alert.addAction(UIAlertAction(title: "Não", style: .default, handler: {_ in
//
//        }))
//        present(alert, animated: true)
    }
}
