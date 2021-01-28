//
//  User_EventViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//

import UIKit
import FBSDKLoginKit

class User_EventViewController: UIViewController {

    var viewModel = User_EventViewModel()
    var nextViewModel = ConfirmEventSubscriptionViewModel()
    
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
        
        setupUI()
        
        if let token = AccessToken.current, !token.isExpired {
            self.viewModel.userToken = token.tokenString
        }
        
        loadData()
        
        
            
    }
    
    func setupUI() {
        buttonDonate.layer.cornerRadius = 15
        buttonSubscribe.layer.cornerRadius = 15
        labelEventDate.text = ""
        labelEventLocal.text = ""
        labelEventTitle.text = ""
        labelEventVacancies.text = ""
        labelEventSubGroupVacancies.text = ""
        labelEventDescription.text = ""
    }
    
    
    func updateUIForSubscription(event: Event) {
        labelEventDate.text = event.data
        labelEventLocal.text = event.local
        labelEventTitle.text = event.titulo
        labelEventVacancies.text = String(event.subgrupos[0].vagasSubgrupo)
        labelEventSubGroupVacancies.text = String(event.subgrupos[0].vagasDisponiveisSubgrupo)
        labelEventDescription.text = event.descricao
        pickerViewSubGroups.reloadComponent(0)
        if !didSubscribe() {
                buttonSubscribe.backgroundColor = UIColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
                buttonSubscribe.isEnabled = true
        }
    }
    
    func loadData() {
        viewModel.getUserToken()
        viewModel.loadData { success in
            if success {
                self.viewModel.connectionReachable = true
                self.viewModel.currentEvent = self.viewModel.arrayEvents[0]
                DispatchQueue.main.async {
                    self.updateUIForSubscription(event: self.viewModel.currentEvent)
                }
//                self.updateUIForSubscription(event: self.viewModel.currentEvent)
                self.availabilityToSubscribe()
            } else {
                self.viewModel.connectionReachable = false
                print("Erro in LoadData from User_Event")
                self.alertFailedInLoadData()
                self.availabilityToSubscribe()
            }
        }
    }
    
    func alertFailedInLoadData() {
        let alert = UIAlertController(title: "Não foi possível carregar o evento", message: "Exibindo evento carregado anteriormente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            if self.viewModel.loadFromDataBase() != nil {
                let loadedEvent = self.viewModel.loadFromDataBase()
                self.labelEventDate.text = loadedEvent[0]?.eventDateDB
                self.labelEventTitle.text = loadedEvent[0]?.eventNameDB
                self.labelEventLocal.text = loadedEvent[0]?.eventAddressDB
                self.labelEventDescription.text = loadedEvent[0]?.eventDescriptionDB
                self.viewModel.subgroup = (loadedEvent[0]?.eventSubgroupDB)!
                self.labelEventVacancies.text = "0"
                self.labelEventSubGroupVacancies.text = "0"
                self.pickerViewSubGroups.reloadComponent(0)
                self.pickerViewSubGroups.isUserInteractionEnabled = false
            }
        }))
        present(alert, animated: true)
    }
    
    func didSubscribe() -> Bool {
        for group in viewModel.arrayEvents[0].subgrupos {
            if group.inscritos.contains(viewModel.currentUser.uid) {
                    buttonSubscribe.backgroundColor = .lightGray
                    buttonSubscribe.isEnabled = false
                return true
            }
        }
        return false
    }
    
    func availabilityToSubscribe() {
        if self.viewModel.currentEvent.subgrupos[0].vagasDisponiveisSubgrupo != nil {
            let vacancy = self.viewModel.currentEvent.subgrupos[0].vagasDisponiveisSubgrupo
            if vacancy > 0 && !didSubscribe() {
                buttonSubscribe.backgroundColor = UIColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
                buttonSubscribe.isEnabled = true
            }
        }
    }
    

    
    @IBAction func profileButton(_ sender: Any) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            profile.currentUser = viewModel.currentUser
            navigationController?.pushViewController(profile, animated: true) }
    }
    
    @IBAction func actionSubscribePressed(_ sender: Any) {
        if didSubscribe() {
            self.viewModel.changeSubgroup()
        } else {
            if let userSubscribe = UIStoryboard(name: "ConfirmEventSubscription", bundle: nil).instantiateInitialViewController() as? ConfirmEventSubscriptionViewController {
                
                userSubscribe.currentEvent = self.viewModel.currentEvent
                userSubscribe.currentSubgroup = self.viewModel.subgroup
                userSubscribe.currentUser = viewModel.currentUser
                
                navigationController?.pushViewController(userSubscribe, animated: true)
            }
        }
    }
    
    @IBAction func actionDonatePressed(_ sender: Any) {
        if let userFinanceData = UIStoryboard(name: "BanksMenu", bundle: nil).instantiateInitialViewController() as? BanksMenuViewController {
                navigationController?.pushViewController(userFinanceData, animated: true)
        }
    }

}

extension User_EventViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let vacancy = viewModel.currentEvent.subgrupos[row].vagasDisponiveisSubgrupo
        self.viewModel.subgroup = viewModel.currentEvent.subgrupos[row].grupo
        labelEventSubGroupVacancies.text = String(vacancy)
        self.availabilityToSubscribe()
    }
    
}

extension User_EventViewController: UIPickerViewDataSource {
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
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if viewModel.arrayEvents != nil && viewModel.arrayEvents.count > 0 {
            let groups = String(viewModel.arrayEvents[0].subgrupos[row].grupo)
            self.viewModel.subgroup = groups
            return groups
        }
        return self.viewModel.subgroup
    }
}


