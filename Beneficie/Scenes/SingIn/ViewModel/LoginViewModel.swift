//
//  LoginViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import Firebase
import UIKit

class LoginViewModel {
    
    var userDefaultID = "WFmXZkVpKIgXTchPcN41Zb9BC3A3"
    var userToken = ""
    var currentUser = User()
    
    var apiManager = APIManager()
    
    func goToSignUpScreen(navigationController: UINavigationController?) {
        if let signUp = UIStoryboard(name: "SingUp", bundle: nil).instantiateInitialViewController() as? SingUpViewController {
            navigationController?.pushViewController(signUp, animated: true)
        }
    }
    
    func goToAdminEventListScreen(navigationController: UINavigationController?) {
        if let admScreen = UIStoryboard(name: "EventList", bundle: nil).instantiateInitialViewController() as? EventListViewController {
            navigationController?.pushViewController(admScreen, animated: true)
        }
    }
    
    func goToUserEventScreen(navigationController: UINavigationController?) {
        if let userSubscription = UIStoryboard(name: "User_Event", bundle: nil).instantiateInitialViewController() as? User_EventViewController {
            navigationController?.pushViewController(userSubscription, animated: true)
            
        }
    }
    
    func getUserToken(onComplete: @escaping ( Bool ) -> Void) {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { (idToken, error) in
            if error != nil {
                //                todo logout user to main screen
                onComplete(false)
                return
            }
            
            self.userToken = idToken!
            onComplete(true)
            return
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
                self.currentUser.isAdmin = user.isAdmin
                
                onComplete(true)
                return
            }
            catch {
                print(error)
            }
        }
        )}
    
    
    func authenticateWithFirebase(user: String, password: String, navigationController: UINavigationController?, didAuthenticate: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: user, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if authResult != nil {
                let accountData = authResult
                self?.getUserToken { (success) in
                    if success {
                        self?.loadUserData { (success) in
                            if success {
                                if let typeUser = self?.currentUser.isAdmin, typeUser == true {
                                    self?.goToAdminEventListScreen(navigationController: navigationController)
                                } else {
                                    self?.goToUserEventScreen(navigationController: navigationController)
                                }
                            }
                        }
                        didAuthenticate(true)
                    } else {
                        didAuthenticate(false)
                    }
                }
            }
        }
    }
   
}
