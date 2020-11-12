//
//  InscricaoAcaoViewController.swift
//  PI_G8_Beneficie
//
//  Created by Dominique Nascimento Bezerra on 10/11/20.
//

import UIKit

class InscricaoAcaoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func actionConfirm(_ sender: Any) {
//
//    }
    @IBAction func actionConfirm(_ sender: Any) {
        if let newView = UIStoryboard(name: "InfosFinanceiras", bundle: nil).instantiateInitialViewController() as? InfosFinanceirasViewController {
            navigationController?.pushViewController(newView, animated: true)
        }
    }
}
