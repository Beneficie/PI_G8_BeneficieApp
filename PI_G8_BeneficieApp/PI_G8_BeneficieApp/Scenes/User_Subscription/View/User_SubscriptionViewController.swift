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
    var event = Event()
    var currentUser = User()
    var subgroup = ""
    
    @IBOutlet weak var labelEventDate: UILabel!
    @IBOutlet weak var labelEventLocal: UILabel!
    @IBOutlet weak var labelEventTitle: UILabel!
    @IBOutlet weak var labelEventVacancies: UILabel!
    @IBOutlet weak var pickerViewSubGroups: UIPickerView!
    @IBOutlet weak var labelEventSubGroupVacancies: UILabel!
    @IBOutlet weak var labelEventDescription: UILabel!
    
    @IBOutlet var buttonDonate: UIButton!
    @IBOutlet var buttonSubscribe: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerViewSubGroups.delegate = self
        pickerViewSubGroups.dataSource = self
        
        buttonDonate.layer.cornerRadius = 15
        buttonSubscribe.layer.cornerRadius = 15

        loadData()
    }
    
    func setUpUI(event: Event) {
        labelEventDate.text = event.data
        labelEventLocal.text = event.local
        labelEventTitle.text = event.titulo
        labelEventVacancies.text = String(event.subgrupos[0].vagasSubgrupo)
        labelEventSubGroupVacancies.text = String(event.subgrupos[0].vagasDisponiveisSubgrupo)
        labelEventDescription.text = event.descricao
        pickerViewSubGroups.reloadComponent(0)
    }
    
    func loadData() {
        viewModel.loadData { success in
            if success {
                self.event = self.viewModel.arrayEvents[0]
                self.setUpUI(event: self.event)
            } else {
                print("FailInLoadData")
                self.alertFailedInLoadData()
            }
        }
    }
    
    func alertFailedInLoadData() {
        labelEventDate.text = ""
        labelEventLocal.text = ""
        labelEventTitle.text = ""
        labelEventVacancies.text = ""
        labelEventSubGroupVacancies.text = ""
        labelEventDescription.text = ""
        let alert = UIAlertController(title: "Erro", message: "Não foi possível carregar o evento", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            if let userSocialNetworks = UIStoryboard(name: "User_SocialNetworks", bundle: nil).instantiateInitialViewController() as? User_SocialNetworksViewController {
                self.present(userSocialNetworks, animated: true, completion: nil)
            }
        }))
        present(alert, animated: true)
    }
    
    func availabilityToSubscribe(vacancy: Int) {
        if vacancy > 0 {
            buttonSubscribe.backgroundColor = UIColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
            buttonSubscribe.isEnabled = true
        } else {
            buttonSubscribe.backgroundColor = .lightGray
            buttonSubscribe.isEnabled = false
        }
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileButton(_ sender: Any) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            profile.currentUser = currentUser
            navigationController?.pushViewController(profile, animated: true) }
    }
    
    @IBAction func actionSubscribePressed(_ sender: Any) {
        if let userSubscribe = UIStoryboard(name: "SubscribeToAction", bundle: nil).instantiateInitialViewController() as? SubscribeToActionViewController {
            
            userSubscribe.currentEvent = event
            userSubscribe.currentSubgroup = subgroup
            userSubscribe.currentUser = currentUser
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let vacancy = viewModel.arrayEvents[0].subgrupos[row].vagasDisponiveisSubgrupo
        labelEventSubGroupVacancies.text = String(vacancy)
        self.availabilityToSubscribe(vacancy: vacancy)
    }
    
}

extension User_SubscriptionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if viewModel.arrayEvents != nil &&
            viewModel.arrayEvents.count > 0 &&
            viewModel.arrayEvents[0].subgrupos != nil &&
            viewModel.arrayEvents[0].subgrupos.count > 0  {
            return viewModel.arrayEvents[0].subgrupos.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let groups = String(viewModel.arrayEvents[0].subgrupos[row].grupo)
        self.subgroup = groups
        return groups
    }
}
