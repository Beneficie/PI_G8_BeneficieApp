//
//  BankInformationsViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 24/11/20.
//

import UIKit

class BankInformationsViewController: UIViewController {

    @IBOutlet weak var BanksListTableView: UITableView!
    @IBOutlet weak var newBankButton: UIButton!
    
    var viewModel = BanksMenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BanksListTableView.delegate = self
        BanksListTableView.dataSource = self
        
        newBankButton.layer.cornerRadius = 15
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileButton(_ sender: Any) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            navigationController?.pushViewController(profile, animated: true)
        }
    }
    

}

extension BankInformationsViewController: UITableViewDelegate {
    
}

extension BankInformationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayBanks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.arrayBanks[indexPath.row].name
        return cell
    }
    
    
}
