//
//  LoginViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 09/11/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController {
        
    //  MARK: - Outlets
    @IBOutlet weak var googleButtonView: GIDSignInButton!
    @IBOutlet weak var googleButtonOutlet: GIDSignInButton!
    @IBOutlet weak var gView: UIView!
    @IBOutlet weak var fBView: UIView!
    
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
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
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
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        fBView.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: fBView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: fBView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        
        loginButton.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
        let buttonText = NSAttributedString(string: "Entre com o Facebook")
        loginButton.setAttributedTitle(buttonText, for: .normal)
        loginButton.permissions = ["public_profile", "email"]
        
        googleButtonOutlet.layer.cornerRadius = 5
        gView.layer.cornerRadius = 5
        gView.layer.borderWidth = 1
        gView.layer.borderColor = CGColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
//        UIColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
        googleButtonView.layer.cornerRadius = 5
        
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
    
    //MARK: - Events
    @IBAction func loginGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
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
//                    if let userSubscription = UIStoryboard(name: "User_Event", bundle: nil).instantiateInitialViewController() as? User_EventViewController {
//                            userSubscription.currentUser = self.currentUser
//                            navigationController?.pushViewController(userSubscription, animated: true)
//                    }
//                } else {
//                    alertToRegister()
                Auth.auth().signIn(withEmail: user, password: password) { [weak self] authResult, error in
                  guard let strongSelf = self else { return }
                    if authResult != nil {
                        let accountData = authResult
                        print(accountData?.user.email)
                        if accountData?.user.email == "admin@admin.com" {
                            if let edit = UIStoryboard(name: "EventList", bundle: nil).instantiateInitialViewController() as? EventListViewController {
                                self?.navigationController?.pushViewController(edit, animated: true)
                            }
                        } else {
                            if let userSubscription = UIStoryboard(name: "User_Event", bundle: nil).instantiateInitialViewController() as? User_EventViewController {
                                self?.navigationController?.pushViewController(userSubscription, animated: true)
                                                }
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

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
          }
        if FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString) != nil {
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            appDelegate!.signToFirebase(credential: credential)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("FBLogOut")
    }
}


