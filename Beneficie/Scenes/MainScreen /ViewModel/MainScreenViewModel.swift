//
//  MaiScreenViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import FBSDKLoginKit
import UIKit

class MainScreenViewModel {
    
    func isTokenExpired() -> Bool {
        if let token = AccessToken.current,
           token.isExpired {
            return true
        } else {
            return false
        }
    }
    
    
    
    func goToUserEventScreen(navigationController: UINavigationController?) {
        if let userSubscription = UIStoryboard(name: "User_Event", bundle: nil).instantiateInitialViewController() as? User_EventViewController {
            navigationController?.pushViewController(userSubscription, animated: true)
        }
    }
    
    func goToUserAdministratorScreen(navigationController: UINavigationController?) {
        if let edit = UIStoryboard(name: "EventList", bundle: nil).instantiateInitialViewController() as? EventListViewController {
            navigationController?.pushViewController(edit, animated: true)
        }
    }
    
    func goToLoginScreen(navigationController: UINavigationController?) {
        if let signIn = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(signIn, animated: true)
        }
    }
    
    func goToSignUp(navigationController: UINavigationController?) {
        if let signUp = UIStoryboard(name: "SingUp", bundle: nil).instantiateInitialViewController() as? SingUpViewController {
            navigationController?.pushViewController(signUp, animated: true)
        }
    }
}
