//
//  SingUpViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 10/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {

    @IBOutlet weak var LoginTextFieldOutlet: UITextField!
    @IBOutlet weak var PasswordTextFieldOutlet: UITextField!
    @IBOutlet weak var ContactTextFieldOutlet: UITextField!
    
    @IBOutlet weak var GoogleButtonOutlet: UIButton!
    @IBOutlet weak var FacebookButtonOutlet: UIButton!
    @IBOutlet weak var SingUpButtonOutlet: UIButton!
    @IBOutlet weak var SingInButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      configureUI()
        
    }
    
    @IBAction func actionSignUpPressed(_ sender: Any) {
        if let userSocialNetworks = UIStoryboard(name: "User_SocialNetworks", bundle: nil).instantiateInitialViewController() as? User_SocialNetworksViewController {
            navigationController?.pushViewController(userSocialNetworks, animated: true)
        }
    }
    
     private func configureUI(){
        
        LoginTextFieldOutlet.keyboardAppearance = .dark
        LoginTextFieldOutlet.leftViewMode = .always
        LoginTextFieldOutlet.borderStyle = .none
        LoginTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        ContactTextFieldOutlet.keyboardAppearance = .dark
        ContactTextFieldOutlet.leftViewMode = .always
        ContactTextFieldOutlet.borderStyle = .none
        ContactTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        PasswordTextFieldOutlet.keyboardAppearance = .dark
        PasswordTextFieldOutlet.leftViewMode = .always
        PasswordTextFieldOutlet.borderStyle = .none
        PasswordTextFieldOutlet.isSecureTextEntry = true
        PasswordTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Contato", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        GoogleButtonOutlet.layer.cornerRadius = 5
        FacebookButtonOutlet.layer.cornerRadius = 5

        
        SingUpButtonOutlet.layer.cornerRadius = 25
        SingUpButtonOutlet.layer.shadowOpacity = 0.3
        SingUpButtonOutlet.layer.shadowRadius = 25
        SingUpButtonOutlet.layer.shadowOffset = .zero
        SingUpButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        
        
        
        let attrbText = NSMutableAttributedString(string: "Já Possui uma conta? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),                                                                                      NSAttributedString.Key.foregroundColor: UIColor.white])
        
             attrbText.append(NSAttributedString(string: "Entrar", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.white]))
             
             SingInButtonOutlet.setAttributedTitle(attrbText, for: .normal)
    }
    

    @IBAction func SingInButton(_ sender: UIButton) {
        if let signIn = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(signIn, animated: true)
        }
    }
    
    @IBAction func SocialLoginButton(_ sender: UIButton) {
        //****** tag = 0 para facebook e tag = 1 para google *********//
        if (sender.tag == 0){
            print("DEBUG: Facebook")
        }else if(sender.tag == 1){
            print("DEBUG: Google")
        }
    }
}
