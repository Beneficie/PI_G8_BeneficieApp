//
//  BankInformationsViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 24/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class BankInformationsViewController: UIViewController {

    @IBOutlet weak var tableViewBanksList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewBanksList.delegate = self
        tableViewBanksList.dataSource = self
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileButton(_ sender: Any) {
        if let Profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            navigationController?.pushViewController(Profile, animated: true)
        }
    }
    

}

extension BankInformationsViewController: UITableViewDelegate {
    
}

extension BankInformationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Banco Nubank"
        return cell
    }
    
    
}
