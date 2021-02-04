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
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var donateButton: UIButton!
    @IBOutlet var subscribeButton: UIButton!
    
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subGroupsPickerView.delegate = self
        subGroupsPickerView.dataSource = self
        
        setupUI()
        
        if let token = AccessToken.current, !token.isExpired {
            self.viewModel.userToken = token.tokenString
        }
        
        self.viewModel.setupValues(currentUser)
        
        loadData()
        
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
        eventTotalVacanciesLabel.text = String(event.subgrupos.first!.vagasSubgrupo)
        eventSubGroupVacanciesLabel.text = String(event.subgrupos.first!.vagasDisponiveisSubgrupo)
        eventDescriptionLabel.text = event.descricao
        subGroupsPickerView.reloadComponent(0)
        loadingActivityIndicator.stopAnimating()
    }
    
    func loadData() {
        loadingActivityIndicator.startAnimating()
        viewModel.loadData { success in
            if success {
                self.viewModel.connectionReachable = true
                self.viewModel.currentEvent = self.viewModel.arrayEvents.first!
                self.viewModel.getUserToken(onComplete: { (success) in
                    if success {
                        DispatchQueue.main.async {
                            self.updateUIForSubscription(event: self.viewModel.currentEvent)
                            self.availabilityToSubscribe()
                        }
                    }
                    self.updateUIForSubscription(event: self.viewModel.currentEvent)
                })
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
            let loadedEvent = self.viewModel.loadFromDataBase()
            if let subgroup = loadedEvent.first?!.eventSubgroupDB {
                self.eventDateLabel.text = loadedEvent.first?!.eventDateDB
                self.eventTitleLabel.text = loadedEvent.first?!.eventNameDB
                self.eventAddressLabel.text = loadedEvent.first?!.eventAddressDB
                self.eventDescriptionLabel.text = loadedEvent.first?!.eventDescriptionDB
                self.viewModel.subgroup = subgroup
                self.eventTotalVacanciesLabel.text = "0"
                self.eventSubGroupVacanciesLabel.text = "0"
                self.subGroupsPickerView.reloadComponent(0)
                self.subGroupsPickerView.isUserInteractionEnabled = false
                self.loadingActivityIndicator.stopAnimating()
            } else {
                self.loadingActivityIndicator.stopAnimating()
                self.showAlert(title: "Não foi possível carregar o evento", message: "Conecte-se para inscrever-se em eventos e muito mais!", okHandler: nil)
            }
        }))
        present(alert, animated: true)
    }
    
    func didSubscribe() -> Bool {
        for group in viewModel.arrayEvents.first!.subgrupos {
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
    
    func showAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        present(alert, animated: true, completion: nil)
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
            self.navigationController?.pushViewController(userFinanceData, animated: true)
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
            viewModel.arrayEvents.first?.subgrupos != nil &&
            (viewModel.arrayEvents.first?.subgrupos.count)! > 0  {
            return (viewModel.arrayEvents.first?.subgrupos.count)!
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if viewModel.arrayEvents != nil && viewModel.arrayEvents.count > 0 {
            let groups = String((viewModel.arrayEvents.first?.subgrupos[row].grupo)!)
            self.viewModel.subgroup = groups
            return groups
        }
        return self.viewModel.subgroup
    }
}


