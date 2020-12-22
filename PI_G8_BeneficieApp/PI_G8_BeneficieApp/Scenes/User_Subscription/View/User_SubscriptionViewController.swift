//
//  User_SubscriptionViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class User_SubscriptionViewController: UIViewController {

    var viewModel = User_SubscriptionViewModel()
    
    @IBOutlet weak var labelEventDate: UILabel!
    @IBOutlet weak var labelEventLocal: UILabel!
    @IBOutlet weak var labelEventTitle: UILabel!
    @IBOutlet weak var labelEventVacancies: UILabel!
    @IBOutlet weak var pickerViewSubGroups: UIPickerView!
    @IBOutlet weak var labelEventSubGroupVacancies: UILabel!
    
//    var viewModel = User_SubscriptionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerViewSubGroups.delegate = self
        pickerViewSubGroups.dataSource = self
        
        loadData()
    }
    
    func setUpUI(event: Event) {
        labelEventDate.text = event.data
        labelEventLocal.text = event.local
        labelEventTitle.text = event.titulo
        labelEventVacancies.text = String(event.vagasTotais)
        labelEventSubGroupVacancies.text = String(event.vagasDisponiveis)
    }
    
    func loadData() {
        viewModel.loadData { success in
            print("Success")
                        self.setUpUI(event: self.viewModel.arrayEvents[0])
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func profileButton(_ sender: Any) {
        if let Profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController { navigationController?.pushViewController(Profile, animated: true) }
    }
    
    @IBAction func actionSubscribePressed(_ sender: Any) {
        if let userSubscribe = UIStoryboard(name: "SubscribeToAction", bundle: nil).instantiateInitialViewController() as? SubscribeToActionViewController {
                navigationController?.pushViewController(userSubscribe, animated: true)
            }
    }
    
    @IBAction func actionDonatePressed(_ sender: Any) {
        if let userFinanceData = UIStoryboard(name: "BanksMenu", bundle: nil).instantiateInitialViewController() as? BanksMenuViewController {
                navigationController?.pushViewController(userFinanceData, animated: true)
        }
    }

}

extension User_SubscriptionViewController: UIPickerViewDelegate {
}

extension User_SubscriptionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.arraySubGroups.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        loadData(row: row)
        return viewModel.arraySubGroups[row]
    }
}
