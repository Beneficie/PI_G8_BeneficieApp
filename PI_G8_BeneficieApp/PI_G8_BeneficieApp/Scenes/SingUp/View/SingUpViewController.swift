//
//  SingUpViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 10/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class SingUpViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldPasswordConfirmation: UITextField!
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldCPF: UITextField!
    
    @IBOutlet weak var googleButtonOutlet: GIDSignInButton!
    @IBOutlet  var facebookButtonOutlet: FBLoginButton!
    @IBOutlet weak var singUpButtonOutlet: UIButton!
    @IBOutlet weak var singInButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark: Delegates
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        textFieldPhoneNumber.delegate = self
        textFieldPasswordConfirmation.delegate = self
        textFieldFullName.delegate = self
        textFieldCPF.delegate = self
        
        
        configureUI()
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        
    }
    
    func authenticationWithEmail() {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if authResult != nil {
                    let accountDataUser = authResult?.user
//                    print(accountDataUser)
                } else {
                    print(error)
                }
              }
        }
    }
        
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSignUpPressed(_ sender: Any) {
        self.authenticationWithEmail()
    }
    
    
    
     private func configureUI(){
        
        textFieldEmail.configureTextField(placeHolder: "Email")
        textFieldEmail.keyboardType = .emailAddress
        textFieldFullName.configureTextField(placeHolder: "Nome Completo")
        textFieldCPF.configureTextField(placeHolder: "CPF")
        textFieldPhoneNumber.configureTextField(placeHolder: "Contato")
        textFieldPhoneNumber.keyboardType = .numbersAndPunctuation
        textFieldPasswordConfirmation.configureTextField(placeHolder: "Confirmar Senha")
        textFieldPassword.configureTextField(placeHolder: "Senha")
       
        
        googleButtonOutlet.layer.cornerRadius = 5
        facebookButtonOutlet.layer.cornerRadius = 5

        
        singUpButtonOutlet.layer.cornerRadius = 25
        singUpButtonOutlet.layer.shadowOpacity = 0.3
        singUpButtonOutlet.layer.shadowRadius = 25
        singUpButtonOutlet.layer.shadowOffset = .zero
        singUpButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        
        
        
        let attrbText = NSMutableAttributedString(string: "Já Possui uma conta? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),                                                                                      NSAttributedString.Key.foregroundColor: UIColor.white])
        
             attrbText.append(NSAttributedString(string: "Entrar", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.white]))
             
             singInButtonOutlet.setAttributedTitle(attrbText, for: .normal)
    }
    

    @IBAction func singInButton(_ sender: UIButton) {
        if let signIn = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(signIn, animated: true)
        }
    }
    
    @IBAction func socialLoginButton(_ sender: UIButton) {
        //****** tag = 0 para facebook e tag = 1 para google *********//
        if (sender.tag == 0){
            
            
        }else if(sender.tag == 1){
            GIDSignIn.sharedInstance().signIn()
        }
    }
}

extension SingUpViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
         case textFieldEmail:
             textFieldFullName.becomeFirstResponder()
         case textFieldFullName:
             textFieldPhoneNumber.becomeFirstResponder()
         case textFieldPhoneNumber:
             textFieldCPF.becomeFirstResponder()
        case textFieldCPF:
            textFieldPassword.becomeFirstResponder()
        case textFieldPassword:
            textFieldPasswordConfirmation.becomeFirstResponder()
         default:
             textField.resignFirstResponder()
         }
         return false
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
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }
}
