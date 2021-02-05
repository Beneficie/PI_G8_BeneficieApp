//
//  ProfileViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 21/11/20.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    var currentUser = User()
    
    static func getView() -> ProfileViewController {
        let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as! ProfileViewController
        return profile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getProfileTitle()
    }
    
    func getProfileTitle() {
        if currentUser.name != "" {
            userNameLabel.text = currentUser.name
        } else {
            userNameLabel.text = currentUser.email
        }
    }
    
    func mainScreenAsRoot() {
        let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        UIViewController.replaceRootViewController(viewController: storyboard.instantiateInitialViewController()!)
    }
    
    func signOut() {
//        guard Auth.auth().currentUser != nil else {
//            return
//        }
        
        do {
            try Auth.auth().signOut()
            AccessToken.current = nil
            let alert = UIAlertController(title: "Até Logo!", message: "Você foi desconectado(a).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.mainScreenAsRoot()
            }))
            present(alert, animated: true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func buttonEmail(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func configurationButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.signOut()
    }
}
