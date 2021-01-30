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
    
    var userDefaultID = "NENpVi3e3qf293IKtKA5so5Zd6g1"
    
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
    
    func authenticateWithFirebase(user: String, password: String, navigationController: UINavigationController?, didAuthenticate: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: user, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if authResult != nil {
                let accountData = authResult
                if accountData?.user.uid == self?.userDefaultID {
                    self?.goToAdminEventListScreen(navigationController: navigationController)
                } else {
                    self?.goToUserEventScreen(navigationController: navigationController)
                }
                didAuthenticate(true)
            } else {
                didAuthenticate(false)
            }
        }
    }
    
}
