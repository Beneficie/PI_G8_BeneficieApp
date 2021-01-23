//
//  LoginViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 09/11/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //  MARK: - Outlets
    @IBOutlet weak var singUpButtonOutlet: UIButton!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInTextField: UITextField!
    
    var eventListViewModel = EventListViewModel()
    var viewModel = LoginViewModel()
    
    var currentUser = User()
    
    //  MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInTextField.delegate = self
        passwordTextField.delegate = self
        
        configureUI()
        loadData()
        
    }
    
    func alertToEmptyFields(field: String){
        let alert = UIAlertController(title: "Atenção", message: "Falta \(field)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true) {
            
        }
    }
    
    func checkEmptyTextFields() -> Bool {
        if logInTextField.text == nil || logInTextField.text!.isEmpty && viewModel.didRegister(userLogin: logInTextField.text!, currentUser: currentUser) == false {
            alertToEmptyFields(field: "usuário")
            return false
        }
        else if passwordTextField.text == nil || passwordTextField.text!.isEmpty {
            alertToEmptyFields(field: "senha")
            return false
        }
        return false
    }
    
    func loadData() {
        viewModel.loadData { success in
            if success {
                self.currentUser = self.viewModel.arrayUsers[0]
            } else {
                print("FailInLoadData")
            }
        }
    }
    
    func alertToRegister() {
        let alert = UIAlertController(title: "Usuário Inválido", message: "Registre-se", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            if let signUp = UIStoryboard(name: "SingUp", bundle: nil).instantiateInitialViewController() as? SingUpViewController {
                self.navigationController?.pushViewController(signUp, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: {_ in
        }))
        present(alert, animated: true)
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
        
        loginButtonOutlet.layer.cornerRadius = 25
        loginButtonOutlet.layer.shadowOpacity = 0.3
        loginButtonOutlet.layer.shadowRadius = 25
        loginButtonOutlet.layer.shadowOffset = .zero
        loginButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        
        let attrbText = NSMutableAttributedString(string: "Não tem conta? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),                                                                                      NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attrbText.append(NSAttributedString(string: "Cadastre-se", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        singUpButtonOutlet.setAttributedTitle(attrbText, for: .normal)
        
    }
    
    //MARK: - Actions
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleLogIn(_ sender: Any) {
        if checkEmptyTextFields() {
            if textFieldDidEndEditing(logInTextField) {
                if let admScreen = UIStoryboard(name: "EventList", bundle: nil).instantiateInitialViewController() as? EventListViewController {
                    navigationController?.pushViewController(admScreen, animated: true)
                }
            }
        } else {
            if let user = logInTextField.text, let password = passwordTextField.text {
//                if viewModel.didRegister(userLogin: user, currentUser: currentUser) {
//                    if let userSubscription = UIStoryboard(name: "User_Subscription", bundle: nil).instantiateInitialViewController() as? User_SubscriptionViewController {
//                            userSubscription.currentUser = self.currentUser
//                            navigationController?.pushViewController(userSubscription, animated: true)
//                    }
//                } else {
//                    alertToRegister()
                Auth.auth().signIn(withEmail: user, password: password) { [weak self] authResult, error in
                  guard let strongSelf = self else { return }
                    if authResult != nil {
                        let accountData = authResult
                        print(accountData?.user)
                        if let userSubscription = UIStoryboard(name: "User_Subscription", bundle: nil).instantiateInitialViewController() as? User_SubscriptionViewController {
//                                                    userSubscription.currentUser = self.currentUser
                            
                            self?.navigationController?.pushViewController(userSubscription, animated: true)
                                            }
                    } else {
                        print(error)
                    }
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
        checkEmptyTextFields()
        handleLogIn(loginButtonOutlet)
        return true
        
    }
    private func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        if let user = textField.text {
            let login = viewModel.isAdmin(user: user)
            if login {
                return true
            }
        }
        return false
    }
}


