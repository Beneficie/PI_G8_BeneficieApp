//
//  MainScreenViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func goToADMFlow(_ sender: UIButton) {
        if let signIn = UIStoryboard(name: "MonthAction", bundle: nil).instantiateInitialViewController() as? MonthActionViewController {
                   navigationController?.pushViewController(signIn, animated: true)
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
