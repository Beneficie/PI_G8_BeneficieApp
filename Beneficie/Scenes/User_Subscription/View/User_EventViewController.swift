//
//  User_EventViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//

import UIKit

class User_EventViewController: UIViewController {

    var viewModel = User_EventViewModel()
    var event = Event()
    var currentUser = User()
    var subgroup = ""
    var connectionReachable = Bool()
    
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
        
        viewModel.getCoreDataDBPath()
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
                self.connectionReachable = true
                self.event = self.viewModel.arrayEvents[0]
                self.setUpUI(event: self.event)
                self.availabilityToSubscribe()
            } else {
                self.connectionReachable = false
                print("FailInLoadData")
                self.alertFailedInLoadData()
                self.availabilityToSubscribe()
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
        let alert = UIAlertController(title: "Não foi possível carregar o evento", message: "Exibindo evento carregado anteriormente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            if self.viewModel.loadFromDataBase() != nil {
                let loadedEvent = self.viewModel.loadFromDataBase()
                self.labelEventDate.text = loadedEvent[0]?.eventDateDB
                self.labelEventTitle.text = loadedEvent[0]?.eventNameDB
                self.labelEventLocal.text = loadedEvent[0]?.eventAddressDB
                self.labelEventDescription.text = loadedEvent[0]?.eventDescriptionDB
                self.subgroup = (loadedEvent[0]?.eventSubgroupDB)!
                self.labelEventVacancies.text = "0"
                self.labelEventSubGroupVacancies.text = "0"
                self.pickerViewSubGroups.reloadComponent(0)
                self.pickerViewSubGroups.isUserInteractionEnabled = false
            }
        }))
        present(alert, animated: true)
    }
    
    func canUserSubscribe() -> Bool {
        if self.connectionReachable == false {
            buttonSubscribe.backgroundColor = .lightGray
            buttonSubscribe.isEnabled = false
//            event.subgrupos[0].inscritos.contains(currentUser.nome) ||
            return false
        } else {
            return true
        }
    }
    
    func availabilityToSubscribe() {
        if canUserSubscribe() {
            let vacancy = event.subgrupos[0].vagasDisponiveisSubgrupo
            if vacancy > 0 || event.subgrupos[0].inscritos.contains(currentUser.nome) {
                buttonSubscribe.backgroundColor = UIColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
                buttonSubscribe.isEnabled = true
            } else {
                buttonSubscribe.backgroundColor = .lightGray
                buttonSubscribe.isEnabled = false
            }
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
        if let userSubscribe = UIStoryboard(name: "ConfirmEventSubscription", bundle: nil).instantiateInitialViewController() as? ConfirmEventSubscriptionViewController {
            
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

extension User_EventViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let vacancy = viewModel.arrayEvents[0].subgrupos[row].vagasDisponiveisSubgrupo
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
            self.subgroup = groups
            return groups
        }
        return subgroup
    }
}


