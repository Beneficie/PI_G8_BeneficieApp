//
//  SingUpViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 10/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    @IBAction func actionSignUpPressed(_ sender: Any) {
        if let userSocialNetworks = UIStoryboard(name: "User_SocialNetworks", bundle: nil).instantiateInitialViewController() as? User_SocialNetworksViewController {
            navigationController?.pushViewController(userSocialNetworks, animated: true)
        }
    }
    

   
}
