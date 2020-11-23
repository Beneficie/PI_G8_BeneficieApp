//
//  User_InformacoesFinanceirasViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class FinancialDetailsViewController: UIViewController {

    @IBOutlet weak var switchButton: UISwitch!
    
    func openSocialNetwork() {
        if let userSocialNetworks = UIStoryboard(name: "User_SocialNetworks", bundle: nil).instantiateInitialViewController() as? User_SocialNetworksViewController {
//            navigationController?.pushViewController(userSocialNetworks, animated: true)
            present(userSocialNetworks, animated: true, completion: nil)
        }
    }
    
    func alertDonation() {
        let alert = UIAlertController(title: "Doação", message: "Deseja marcar como doado?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Realizei Doação", style: .default, handler: {_ in
            self.switchButton.isOn = true
            self.openSocialNetwork()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: {_ in
        }))
        present(alert, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchDonation(_ sender: Any) {
        
        switch switchButton.isOn {
        case true:
            self.alertDonation()
        case false:
            self.openSocialNetwork()
        }
    }
    
}
