//
//  SubscribeToActionViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 23/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class SubscribeToActionViewController: UIViewController {

    func openFinancialScreen() {
        if let userFinanceData = UIStoryboard(name: "BanksMenu", bundle: nil).instantiateInitialViewController() as? BanksMenuViewController {
            navigationController?.pushViewController(userFinanceData, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Inscrição Confirmada", message: "Você foi inscrito na ação", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            print("OK")
            self.openFinancialScreen()
        }))
        present(alert, animated: true)
        
    }
    

}
