//
//  EventListViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 18/12/20.
//

import Foundation
import FirebaseAuth

class EventListViewModel {
    
    var arrayEvents = [EventADM]()
    
    var apiManager = APIManager()
    
    var userToken = ""
    var currentUser = User()
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
            apiManager.getAsArray(
                url: "https://beneficie-app.herokuapp.com/beneficie/events/") { (responseData) in
                
    //            let jsonData = try Data(contentsOf: URL(fileURLWithPath:filePath), options: .alwaysMapped)
                let jsonDecoder = JSONDecoder()
                
                self.arrayEvents = try! jsonDecoder.decode(Array<EventADM>.self,from: responseData)
                
                onComplete(true)
            }
            onFailure: { (error) in
                print("Error \(error)")
                onComplete(false)
            }
        }
    
    func getUserToken(onComplete: @escaping ( Bool ) -> Void ) {
        let user = Auth.auth().currentUser
        user?.getIDTokenForcingRefresh(true) { (idToken, error) in
            if error != nil {
                //                todo logout user to main screen
                onComplete(false)
                return
            }
            
            self.userToken = idToken!
            
            self.loadUserData { (success) in
                if success {
                    
                    onComplete(true)
                    return
                } else {
                    onComplete(false)
                    print("loadUserData success false")
                }
            }
        }
    }
    
    func loadUserData(onComplete: @escaping ( Bool ) -> Void ) {
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
                
                onComplete(true)
                return
            }
            catch {
                print(error)
            }
        }
        )}
    
    func goToProfileScreen(user: User, navigationController: UINavigationController?) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            profile.currentUser = user
            navigationController?.pushViewController(profile, animated: true) }
    }
}
