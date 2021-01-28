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

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldPasswordConfirmation: UITextField!
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var googleButtonView: GIDSignInButton!
    @IBOutlet weak var googleButtonOutlet: GIDSignInButton!
    @IBOutlet weak var gView: UIView!
    @IBOutlet weak var fBView: UIView!
    @IBOutlet weak var singUpButtonOutlet: UIButton!
    @IBOutlet weak var singInButtonOutlet: UIButton!
    
    var viewModel = SignUpViewModel()
    var nextViewModel = User_EventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegates
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        textFieldPhoneNumber.delegate = self
        textFieldPasswordConfirmation.delegate = self
        textFieldFullName.delegate = self
        
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
        
        loginButton.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
        let buttonText = NSAttributedString(string: "Entre com o Facebook")
        loginButton.setAttributedTitle(buttonText, for: .normal)
        
        // MARK: - Google button setup
        googleButtonOutlet.layer.cornerRadius = 5
        gView.layer.cornerRadius = 5
        googleButtonView.layer.cornerRadius = 5
        
        // MARK: - Textfields setup
        textFieldEmail.configureTextField(placeHolder: "Email")
        textFieldEmail.keyboardType = .emailAddress
        textFieldFullName.configureTextField(placeHolder: "Nome Completo")
        textFieldPhoneNumber.configureTextField(placeHolder: "Contato")
        textFieldPhoneNumber.keyboardType = .numbersAndPunctuation
        textFieldPasswordConfirmation.configureTextField(placeHolder: "Confirmar Senha")
        textFieldPassword.configureTextField(placeHolder: "Senha")
        
        // textFieldPhoneNumber.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "(##) ##### - ####")
        
        // MARK: - SignIn button setup
        singUpButtonOutlet.layer.cornerRadius = 25
        singUpButtonOutlet.layer.shadowOpacity = 0.3
        singUpButtonOutlet.layer.shadowRadius = 25
        singUpButtonOutlet.layer.shadowOffset = .zero
        singUpButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        
        let attrbText = NSMutableAttributedString(string: "Já Possui uma conta? ",
                                                  attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                                                               NSAttributedString.Key.foregroundColor: UIColor.white])
        
             attrbText.append(NSAttributedString(string: "Entrar",
                                                 attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),
                                                              NSAttributedString.Key.foregroundColor: UIColor.white]))
             singInButtonOutlet.setAttributedTitle(attrbText, for: .normal)
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
        if let email = textFieldEmail.text, let password = textFieldPassword.text, let fullName = textFieldFullName.text, let phoneNumber = textFieldPhoneNumber.text, let passwordConfirmation = textFieldPasswordConfirmation.text {
//            , fullName: fullName, phoneNumber: phoneNumber
            if password != passwordConfirmation {
                self.showAlert(title: "Erro", message: "As senhas fornecidas não conferem", okHandler: {(ok) in
                    self.textFieldPassword.becomeFirstResponder()
                }, cancelHandler: nil)
            } else {
                nextViewModel.currentUser.name = fullName
                nextViewModel.currentUser.phoneNumber = phoneNumber
                self.viewModel.authenticationWithEmail(email: email, password: password, navigationController: self.navigationController)
            }
        }
    }
}

extension SingUpViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else if textField == textFieldFullName {
            textField.resignFirstResponder()
            textFieldEmail.becomeFirstResponder()
            return true
        } else if textField == textFieldEmail {
            textField.resignFirstResponder()
            textFieldPhoneNumber.becomeFirstResponder()
            return true
        } else if textField == textFieldPhoneNumber {
            textField.resignFirstResponder()
            textFieldPassword.becomeFirstResponder()
            return true
        } else if textField == textFieldPassword {
            textField.resignFirstResponder()
            textFieldPasswordConfirmation.becomeFirstResponder()
            return true
        } else if textField == textFieldPasswordConfirmation {
            textField.resignFirstResponder()
            if let email = textFieldEmail.text, let password = textFieldPassword.text {
                self.viewModel.authenticationWithEmail(email: email, password: password, navigationController: self.navigationController)
            }
            return true
        }else {
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
