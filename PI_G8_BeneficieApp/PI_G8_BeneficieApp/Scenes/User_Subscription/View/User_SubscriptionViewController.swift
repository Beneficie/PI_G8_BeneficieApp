//
//  User_SubscriptionViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class User_SubscriptionViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var viewModel = User_SubscriptionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
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
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.arraySubGroups[row]
    }
}
