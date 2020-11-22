//
//  AcaoDoMesConfirmacaoViewController.swift
//  PI_G8_Beneficie
//
//  Created by Aline Sena on 22/11/20.
//

import UIKit

class AcaoDoMesConfirmacaoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func actionConfirm(_ sender: Any) {
//
//    }
    @IBAction func actionConfirm(_ sender: Any) {
        if let newView = UIStoryboard(name: "AcaoDoMes", bundle: nil).instantiateInitialViewController() as? AcaoDoMesViewController {
            navigationController?.pushViewController(newView, animated: true)
        }
    }
}
