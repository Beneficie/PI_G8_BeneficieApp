//
//  ProfileViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 21/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var labelUserName: UILabel!
    var currentUser = User()
    
    static func getView() -> ProfileViewController {
        let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as! ProfileViewController
        return profile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelUserName.text = currentUser.nome
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
        navigationController?.popViewController(animated: true)
    }
}
