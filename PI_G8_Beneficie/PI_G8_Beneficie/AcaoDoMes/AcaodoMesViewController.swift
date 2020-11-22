//
//  AcaodoMesViewController.swift
//  PI_G8_Beneficie
//
//  Created by Aline Sena on 22/11/20.
//

import UIKit

class AcaoDoMesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func actionDoar(_ sender: Any) {
        if let newView = UIStoryboard(name: "InfosFinanceiras", bundle: nil).instantiateInitialViewController() as? InfosFinanceirasViewController {
            navigationController?.pushViewController(newView, animated: true)
        }
    }
    @IBAction func actionInscrever(_ sender: Any) {
        if let newView2 = UIStoryboard(name: "AcaoDoMesConfirmacao", bundle: nil).instantiateInitialViewController() as? AcaoDoMesConfirmacaoViewController {
            navigationController?.pushViewController(newView2, animated: true)
        }
    }
    
}
