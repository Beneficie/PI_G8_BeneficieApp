//
//  SingUpViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 10/11/20.
//

import UIKit
//import Firebase
import GoogleSignIn
import FBSDKLoginKit

class SingUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var googleButtonView: GIDSignInButton!
    @IBOutlet weak var googleButtonOutlet: GIDSignInButton!
    @IBOutlet weak var gView: UIView!
    @IBOutlet weak var fBView: UIView!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var singInButton: UIButton!
    
    var viewModel = SignUpViewModel()
    var nextViewModel = User_EventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegates
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordConfirmationTextField.delegate = self
        fullNameTextField.delegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        
        
        configureUI()
    }
    
    func showAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: cancelHandler))
        present(alert, animated: true, completion: nil)
    }
    
     private func configureUI(){
        // MARK: - Facebook button setup
        let loginButton = FBLoginButton()
        fBView.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: fBView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: fBView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        
        loginButton.frame = CGRect(x: 0, y: 0, width: 210, height: 30)
        let buttonText = NSAttributedString(string: "Entre com o Facebook")
        loginButton.setAttributedTitle(buttonText, for: .normal)
        
        // MARK: - Google button setup
        googleButtonOutlet.layer.cornerRadius = 5
        gView.layer.cornerRadius = 5
        googleButtonView.layer.cornerRadius = 5
        
        // MARK: - Textfields setup
        emailTextField.configureTextField(placeHolder: "Email")
        emailTextField.keyboardType = .emailAddress
        fullNameTextField.configureTextField(placeHolder: "Nome Completo")
        phoneNumberTextField.configureTextField(placeHolder: "Contato")
        phoneNumberTextField.keyboardType = .numbersAndPunctuation
        passwordConfirmationTextField.configureTextField(placeHolder: "Confirmar Senha")
        passwordTextField.configureTextField(placeHolder: "Senha")
        
        // MARK: - SignIn button setup
        singUpButton.layer.cornerRadius = 25
        singUpButton.layer.shadowOpacity = 0.3
        singUpButton.layer.shadowRadius = 25
        singUpButton.layer.shadowOffset = .zero
        singUpButton.layer.shadowColor = UIColor.black.cgColor
        
        let attrbText = NSMutableAttributedString(string: "Já Possui uma conta? ",
                                                  attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                                                               NSAttributedString.Key.foregroundColor: UIColor.white])
        
             attrbText.append(NSAttributedString(string: "Entrar",
                                                 attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),
                                                              NSAttributedString.Key.foregroundColor: UIColor.white]))
             singInButton.setAttributedTitle(attrbText, for: .normal)
    }
    
    // MARK: - IBActions
    @IBAction func singInButton(_ sender: UIButton) {
        self.viewModel.goToLoginScreen(navigationController: self.navigationController)
    }
    
    @IBAction func googleLoginButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signUpTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, let fullName = fullNameTextField.text, let phoneNumber = phoneNumberTextField.text, let passwordConfirmation = passwordConfirmationTextField.text {
            if password != passwordConfirmation {
                self.showAlert(title: "Erro", message: "As senhas fornecidas não conferem", okHandler: {(ok) in
                    self.passwordTextField.becomeFirstResponder()
                }, cancelHandler: nil)
            } else {
                self.viewModel.authenticationWithEmail(email: email, password: password, fullName: fullName, phoneNumber: phoneNumber, navigationController: self.navigationController)
            }
        }
    }
}

extension SingUpViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else if textField == fullNameTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
            return true
        } else if textField == emailTextField {
            textField.resignFirstResponder()
            phoneNumberTextField.becomeFirstResponder()
            return true
        } else if textField == phoneNumberTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            passwordConfirmationTextField.becomeFirstResponder()
            return true
        } else if textField == passwordConfirmationTextField {
            textField.resignFirstResponder()
            if let email = emailTextField.text, let password = passwordTextField.text, let fullName = fullNameTextField.text, let phoneNumber = phoneNumberTextField.text {
                self.viewModel.authenticationWithEmail(email: email, password: password, fullName: fullName, phoneNumber: phoneNumber, navigationController: self.navigationController)
            }
            return true
        } else {
            return false
        }
    }
}

extension UIViewController {
    class func replaceRootViewController(viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        else {
            return
        }
        let rootViewController = window.rootViewController!
        viewController.view.frame = rootViewController.view.frame
        viewController.view.layoutIfNeeded()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionFlipFromLeft,
                          animations: { window.rootViewController = viewController }, completion: nil)
    }
}
