//
//  LoginViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 09/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //  MARK: - Outlets
    @IBOutlet weak var singUpButtonOutlet: UIButton!
    @IBOutlet weak var LoginButtonOutlet: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInTextField: UITextField!
    
    var eventListViewModel = EventListViewModel()
    var viewModel = LoginViewModel()
    
    func isInformationValid() -> Bool {
        if logInTextField.text == nil || logInTextField.text!.isEmpty {
            alertToMissingAnswer(field: "usuário")
            return false
        }
        else if passwordTextField.text == nil || passwordTextField.text!.isEmpty {
            alertToMissingAnswer(field: "senha")
            return false
        }
        return true
    }
    
    func alertToMissingAnswer(field: String){
            let alert = UIAlertController(title: "Atenção", message: "Falta \(field)", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true) {
               
            }
        }
    
    func isAdmin(user: String) -> Bool{
        if user.contains("admin@admin") {
            return true
        } else {
            return false
        }
}
    
//    func loadDataFromAPI() {
//        eventListViewModel.loadData { success in
//            
//        }
//    }
    
    //  MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        logInTextField.delegate = self
        passwordTextField.delegate = self
        
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
        
        singUpButtonOutlet.setAttributedTitle(attrbText, for: .normal)
        
        
    
    }
    
    //MARK: - Actions
   
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleLogIn(_ sender: Any) {
        if isInformationValid() {
            if textFieldDidEndEditing(logInTextField) {
                if let admScreen = UIStoryboard(name: "EventList", bundle: nil).instantiateInitialViewController() as? EventListViewController {
                    navigationController?.pushViewController(admScreen, animated: true)
                }
            } else {
                if let userSubscription = UIStoryboard(name: "User_Subscription", bundle: nil).instantiateInitialViewController() as? User_SubscriptionViewController {
                    navigationController?.pushViewController(userSubscription, animated: true)
                }
            }
        }
    }
    
    @IBAction func handleForgotPassword(_ sender: UIButton) {
        print("DEBUG: Forgot Password")
    }
    @IBAction func handleSingUp(_ sender: UIButton) {
        if let signUp = UIStoryboard(name: "SingUp", bundle: nil).instantiateInitialViewController() as? SingUpViewController {
            navigationController?.pushViewController(signUp, animated: true)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if logInTextField.text != nil {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        isInformationValid()
        handleLogIn(LoginButtonOutlet)
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        if let user = textField.text {
            var login = isAdmin(user: user)
            if login {
                return true
            }
        }
        return false
    }
}
