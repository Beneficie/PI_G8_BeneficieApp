//
//  PrincipalViewController.swift
//  PI_G8_Beneficie
//
//  Created by Dominique Nascimento Bezerra on 10/11/20.
//

import UIKit

class PrincipalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func actionLogIn(_ sender: Any) {
        if let newView = UIStoryboard(name: "InscricaoAcao", bundle: nil).instantiateInitialViewController() as? InscricaoAcaoViewController {
            navigationController?.pushViewController(newView, animated: true)
        }
    }
    @IBAction func actionSignUp(_ sender: Any) {
        if let newView2 = UIStoryboard(name: "RedesSociais", bundle: nil).instantiateInitialViewController() as? RedesSociaisViewController {
            navigationController?.pushViewController(newView2, animated: true)
        }
    }
    
}
