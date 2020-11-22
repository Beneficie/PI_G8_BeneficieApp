//
//  LoginViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 09/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var SingUpButtonOutlet: UIButton!
    @IBOutlet weak var LoginButtonOutlet: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    //MARK: - Helper Functions
    
    func configureUI(){
        logInTextField.keyboardAppearance = .dark
        logInTextField.leftViewMode = .always
        logInTextField.borderStyle = .none
        
        passwordTextField.keyboardAppearance = .dark
        passwordTextField.leftViewMode = .always
        passwordTextField.borderStyle = .none
        passwordTextField.isSecureTextEntry = true
        
        LoginButtonOutlet.layer.cornerRadius = 25
        LoginButtonOutlet.layer.shadowOpacity = 0.3
        LoginButtonOutlet.layer.shadowRadius = 25
        LoginButtonOutlet.layer.shadowOffset = .zero
        LoginButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        
        let attrbText = NSMutableAttributedString(string: "Não tem conta? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),                                                                                      NSAttributedString.Key.foregroundColor: UIColor.lightGray])
   
        attrbText.append(NSAttributedString(string: "Cadastre-se", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        SingUpButtonOutlet.setAttributedTitle(attrbText, for: .normal)
        
        
    
    }
    
    //MARK: - Actions
   
    @IBAction func HandleLogIn(_ sender: Any) {
        if let userSubscription = UIStoryboard(name: "User_Subscription", bundle: nil).instantiateInitialViewController() as? User_SubscriptionViewController {
            navigationController?.pushViewController(userSubscription, animated: true)
        }
    }
    
    @IBAction func HandleForgotPassword(_ sender: UIButton) {
        print("DEBUG: Forgot Password")
    }
    @IBAction func HandleSingUp(_ sender: UIButton) {
        if let signUp = UIStoryboard(name: "SingUp", bundle: nil).instantiateInitialViewController() as? SingUpViewController {
            navigationController?.pushViewController(signUp, animated: true)
        }
    }
}
