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
    
    func goToLoginScreen(navigationController: UINavigationController?) {
        if let signIn = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(signIn, animated: true)
        }
    }
    
    func goToUserEventScreen(navigationController: UINavigationController?) {
        if let userSubscription = UIStoryboard(name: "User_Event", bundle: nil).instantiateInitialViewController() as? User_EventViewController {
            
            navigationController?.pushViewController(userSubscription, animated: true)
        }
    }
    

    
    // MARK: - Firebase Authentication
    func authenticationWithEmail(email: String, password: String, navigationController: UINavigationController?) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                let accountDataUser = authResult?.user
                self.goToUserEventScreen(navigationController: navigationController)
            } else {
                print(error)
            }
        }
    }
}
