//
//  MainScreenViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let token = AccessToken.current,
           !token.isExpired {
            if let userSubscription = UIStoryboard(name: "User_Subscription", bundle: nil).instantiateInitialViewController() as? User_SubscriptionViewController {
                self.navigationController?.pushViewController(userSubscription, animated: true)
            }
        }
        
    }
    
    @IBAction func goToADMFlow(_ sender: UIButton) {
        if let edit = UIStoryboard(name: "EventList", bundle: nil).instantiateInitialViewController() as? EventListViewController {
            navigationController?.pushViewController(edit, animated: true)
        }
    }
    
    
    @IBAction func actionSignIn(_ sender: Any) {
        if let signIn = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(signIn, animated: true)
        }
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        if let signUp = UIStoryboard(name: "SingUp", bundle: nil).instantiateInitialViewController() as? SingUpViewController {
            navigationController?.pushViewController(signUp, animated: true)
        }
    }
    
}
