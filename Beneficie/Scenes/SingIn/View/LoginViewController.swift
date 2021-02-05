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
        
    @IBOutlet weak var googleButtonView: GIDSignInButton!
    @IBOutlet weak var googleButtonOutlet: GIDSignInButton!
    @IBOutlet weak var gView: UIView!
    @IBOutlet weak var fBView: UIView!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    
    var viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegates
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        configureUI()
    }
    
    func showAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: cancelHandler))
        present(alert, animated: true, completion: nil)
    }
    
    func alertToInvalidUserOrPassword() {
        showAlert(title: "Erro", message: "Cheque as informações e tente novamente", okHandler: nil, cancelHandler: nil)
    }
    
    func alertToEmptyFields(field: String){
        showAlert(title: "Atenção", message: "Falta \(field)", okHandler: nil, cancelHandler: nil)
    }
    
    func checkEmptyTextFields() -> Bool {
        if loginTextField.text == nil || loginTextField.text!.isEmpty {
            alertToEmptyFields(field: "usuário")
            return false
        }
        else if passwordTextField.text == nil || passwordTextField.text!.isEmpty {
            alertToEmptyFields(field: "senha")
            return false
        }
        return false
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleLogIn(_ sender: Any) {
        if let user = loginTextField.text, let password = passwordTextField.text {
            self.viewModel.authenticateWithFirebase(user: user, password: password,
                                                    navigationController: self.navigationController,
                                                    didAuthenticate: {(result) in
                if !result {
                    self.alertToInvalidUserOrPassword()
                }
            }
        )}
    }
    
    @IBAction func handleForgotPassword(_ sender: UIButton) {
        print("DEBUG: Forgot Password")
    }
    @IBAction func handleSingUp(_ sender: UIButton) {
        viewModel.goToSignUpScreen(navigationController: self.navigationController)
    }
    
    func configureUI() {
        let fBButton = configureFacebookButton()
        addSubview(button: fBButton)
        configureLayout(button: fBButton)
        configureConstraints(button: fBButton)

        
    }
    
    func addSubview(button: FBLoginButton) {
        fBView.addSubview(button)
    }
    
    func configureLayout(button: FBLoginButton) {
        button.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
        let buttonText = NSAttributedString(string: "Entre com o Facebook")
        button.setAttributedTitle(buttonText, for: .normal)
        
        googleButtonOutlet.layer.cornerRadius = 5
        gView.layer.cornerRadius = 5
        gView.layer.borderWidth = 1
        gView.layer.borderColor = CGColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
        googleButtonView.layer.cornerRadius = 5
        
        loginTextField.keyboardAppearance = .dark
        loginTextField.leftViewMode = .always
        loginTextField.borderStyle = .none
        
        passwordTextField.keyboardAppearance = .dark
        passwordTextField.leftViewMode = .always
        passwordTextField.borderStyle = .none
        passwordTextField.isSecureTextEntry = true
        
        loginButton.layer.cornerRadius = 25
        loginButton.layer.shadowOpacity = 0.3
        loginButton.layer.shadowRadius = 25
        loginButton.layer.shadowOffset = .zero
        loginButton.layer.shadowColor = UIColor.black.cgColor
        
        let attrbText = NSMutableAttributedString(string: "Não tem conta? ",
                                                  attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                                                               NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attrbText.append(NSAttributedString(string: "Cadastre-se",
                                            attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),
                                                         NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        singUpButton.setAttributedTitle(attrbText, for: .normal)
    }
    
    func configureConstraints(button: FBLoginButton) {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal, toItem: fBView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal, toItem: fBView,
                                                    attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        
    }
    
    func configureFacebookButton() -> FBLoginButton {
        
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email"]
        
        return loginButton
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else if textField == loginTextField, loginTextField != nil {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else {
            checkEmptyTextFields()
            
        }
        handleLogIn(loginButton)
        return true
    }
}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
          }
        if let currentAccessToken = AccessToken.current {
            let credential = FacebookAuthProvider.credential(withAccessToken: currentAccessToken.tokenString)
            let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            appDelegate!.signToFirebase(credential: credential)
        } else {
            showAlert(title: "Erro", message: "Forneça a permissão para continuar", okHandler: nil, cancelHandler: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) { print("FBLogOut") }
}


