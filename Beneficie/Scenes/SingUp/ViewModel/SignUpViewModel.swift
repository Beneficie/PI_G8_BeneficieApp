//
//  SignUpViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import UIKit
import Firebase

class SignUpViewModel {
    
    var fullName = ""
    var phoneNumber = ""
    var user = User()
    var userToken = ""
    var apiManager = APIManager()
    
    func goToLoginScreen(navigationController: UINavigationController?) {
        if let signIn = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(signIn, animated: true)
        }
    }
    
    func goToUserEventScreen(navigationController: UINavigationController?) {
        if let userSubscription = UIStoryboard(name: "User_Event", bundle: nil).instantiateInitialViewController() as? User_EventViewController {
            userSubscription.currentUser = user
            navigationController?.pushViewController(userSubscription, animated: true)
        }
    }
    
    func updateUser(currentUser: User, onComplete: @escaping (Bool) -> Void) {
        apiManager.updateUserInformation(user: currentUser) { isOk in
            onComplete(isOk)
        }
    }

    
    // MARK: - Firebase Authentication
    func authenticationWithEmail(email: String, password: String, fullName: String, phoneNumber: String, navigationController: UINavigationController?) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if authResult != nil, let accountDataUser = authResult?.user {
                self.user._id = accountDataUser.providerID
                self.user.uid = accountDataUser.uid
                self.user.email = accountDataUser.email
                self.getUserToken { (success) in
                    if success {
                        self.loadUserData(onComplete: { success in
                            if success {
                                self.user.name = fullName
                                self.user.phoneNumber = phoneNumber
                                self.updateUser(currentUser: self.user, onComplete: { success in
                                    if success {
                                        self.goToUserEventScreen(navigationController: navigationController)
                                    } else {
                                        print("failed in updating user")
                                    }
                                })
                            }
                        })
                    } else {
                        print(error)
                    }
                }
            }
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
                self.user.uid = user.uid
                self.user._id = user._id
                self.user.name = user.name
                self.user.email = user.email
                self.user.phoneNumber = user.phoneNumber
                
                onComplete(true)
                return
            }
            catch {
                print(error)
            }
        }
        )}
}
