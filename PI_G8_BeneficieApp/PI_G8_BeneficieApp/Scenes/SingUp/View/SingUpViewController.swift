//
//  SingUpViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 10/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {

    @IBOutlet weak var loginTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var contactTextFieldOutlet: UITextField!
    @IBOutlet weak var ConfirmPasswordTextFieldOutlet: UITextField!
    @IBOutlet weak var FullNameTextFieldOutlet: UITextField!
    @IBOutlet weak var CPFTextFieldOutlet: UITextField!
    
    @IBOutlet weak var googleButtonOutlet: UIButton!
    @IBOutlet weak var facebookButtonOutlet: UIButton!
    @IBOutlet weak var singUpButtonOutlet: UIButton!
    @IBOutlet weak var singInButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextFieldOutlet.delegate = self
        passwordTextFieldOutlet.delegate = self
        contactTextFieldOutlet.delegate = self
        ConfirmPasswordTextFieldOutlet.delegate = self
        FullNameTextFieldOutlet.delegate = self
        CPFTextFieldOutlet.delegate = self
      configureUI()
        
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSignUpPressed(_ sender: Any) {
        
    }
    
     private func configureUI(){
        
        loginTextFieldOutlet.configureTextField(placeHolder: "Email")
        loginTextFieldOutlet.keyboardType = .emailAddress
        FullNameTextFieldOutlet.configureTextField(placeHolder: "Nome Completo")
        CPFTextFieldOutlet.configureTextField(placeHolder: "CPF")
        contactTextFieldOutlet.configureTextField(placeHolder: "Contato")
        contactTextFieldOutlet.keyboardType = .numbersAndPunctuation
        ConfirmPasswordTextFieldOutlet.configureTextField(placeHolder: "Confirmar Senha")
        passwordTextFieldOutlet.configureTextField(placeHolder: "Senha")
       
        
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
            print("DEBUG: Facebook")
        }else if(sender.tag == 1){
            print("DEBUG: Google")
        }
    }
}

extension SingUpViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
         case loginTextFieldOutlet:
             FullNameTextFieldOutlet.becomeFirstResponder()
         case FullNameTextFieldOutlet:
             contactTextFieldOutlet.becomeFirstResponder()
         case contactTextFieldOutlet:
             CPFTextFieldOutlet.becomeFirstResponder()
        case CPFTextFieldOutlet:
            passwordTextFieldOutlet.becomeFirstResponder()
        case passwordTextFieldOutlet:
            ConfirmPasswordTextFieldOutlet.becomeFirstResponder()
         default:
             textField.resignFirstResponder()
         }
         return false
      }
}
