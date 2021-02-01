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
    
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventAddressLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTotalVacanciesLabel: UILabel!
    @IBOutlet weak var subGroupsPickerView: UIPickerView!
    @IBOutlet weak var eventSubGroupVacanciesLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    @IBOutlet var donateButton: UIButton!
    @IBOutlet var subscribeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subGroupsPickerView.delegate = self
        subGroupsPickerView.dataSource = self
        
        setupUI()
        
        if let token = AccessToken.current, !token.isExpired {
            self.viewModel.userToken = token.tokenString
        }
        
        loadData()
        
        
        print(subscribeButton.state)
    }
    
    func setupUI() {
        donateButton.layer.cornerRadius = 15
        subscribeButton.layer.cornerRadius = 15
        eventDateLabel.text = ""
        eventAddressLabel.text = ""
        eventTitleLabel.text = ""
        eventTotalVacanciesLabel.text = ""
        eventSubGroupVacanciesLabel.text = ""
        eventDescriptionLabel.text = ""
    }
    
    
    func updateUIForSubscription(event: Event) {
        eventDateLabel.text = event.data
        eventAddressLabel.text = event.local
        eventTitleLabel.text = event.titulo
        eventTotalVacanciesLabel.text = String(event.subgrupos[0].vagasSubgrupo)
        eventSubGroupVacanciesLabel.text = String(event.subgrupos[0].vagasDisponiveisSubgrupo)
        eventDescriptionLabel.text = event.descricao
        subGroupsPickerView.reloadComponent(0)
        if !didSubscribe() {
//                subscribeButton.backgroundColor = UIColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
//                subscribeButton.isEnabled = true
        }
        print(subscribeButton.state)
    }
    
    func loadData() {
        
        viewModel.loadData { success in
            if success {
                self.viewModel.connectionReachable = true
                self.viewModel.currentEvent = self.viewModel.arrayEvents[0]
                self.viewModel.getUserToken { (success) in
                    if success {
                        DispatchQueue.main.async {
                            self.updateUIForSubscription(event: self.viewModel.currentEvent)
                            self.availabilityToSubscribe()
                        }
                    }
                    self.updateUIForSubscription(event: self.viewModel.currentEvent)
                }
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
                self.eventDateLabel.text = loadedEvent[0]?.eventDateDB
                self.eventTitleLabel.text = loadedEvent[0]?.eventNameDB
                self.eventAddressLabel.text = loadedEvent[0]?.eventAddressDB
                self.eventDescriptionLabel.text = loadedEvent[0]?.eventDescriptionDB
                self.viewModel.subgroup = (loadedEvent[0]?.eventSubgroupDB)!
                self.eventTotalVacanciesLabel.text = "0"
                self.eventSubGroupVacanciesLabel.text = "0"
                self.subGroupsPickerView.reloadComponent(0)
                self.subGroupsPickerView.isUserInteractionEnabled = false
            }
        }))
        present(alert, animated: true)
    }
    
    func didSubscribe() -> Bool {
        for group in viewModel.arrayEvents[0].subgrupos {
            if group.inscritos.contains(viewModel.currentUser.uid) {
                subscribeButton.backgroundColor = .lightGray
                subscribeButton.isEnabled = false
                return true
            }
        }
        subscribeButton.backgroundColor = UIColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
        subscribeButton.isEnabled = true
        return false
    }
    
    func availabilityToSubscribe() {
        if let vacancy = self.viewModel.currentEvent.subgrupos.first?.vagasDisponiveisSubgrupo {
            if vacancy > 0 && !didSubscribe() {
                
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
        eventSubGroupVacanciesLabel.text = String(vacancy)
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


