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
        availabilityToSubscribe()
        
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
        self.viewModel.getUserToken(onComplete: { (success) in
            if success {
                self.viewModel.loadData(userToken: self.viewModel.userToken, onComplete: { success in
                    if success {
                        self.viewModel.connectionReachable = true
                        self.viewModel.subgroup = self.viewModel.currentEvent.subgrupos.first!
                        DispatchQueue.main.async {
                            self.updateUIForSubscription(event: self.viewModel.currentEvent)
                            self.availabilityToSubscribe()
                        }
                        
                    } else {
                        self.viewModel.connectionReachable = false
                        print("Erro in LoadData from User_Event")
                        self.alertFailedInLoadData()
                        self.availabilityToSubscribe()
                    }
                })
            }
//            self.updateUIForSubscription(event: self.viewModel.currentEvent)
        })
        loadingActivityIndicator.startAnimating()
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
                self.viewModel.subgroup.grupo = subgroup
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
        for group in viewModel.currentEvent.subgrupos {
            if group.inscritos.contains(viewModel.currentUser.uid) {
                return true
            }
        }
        return false
    }
    
    func availabilityToSubscribe() {
        let vacancy = self.viewModel.subgroup.vagasDisponiveisSubgrupo
        if vacancy > 0 && !didSubscribe() {
            subscribeButton.backgroundColor = UIColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
            subscribeButton.isEnabled = true
        } else {
            subscribeButton.backgroundColor = .lightGray
            subscribeButton.isEnabled = false
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
        if let userSubscribe = UIStoryboard(name: "ConfirmEventSubscription", bundle: nil).instantiateInitialViewController() as? ConfirmEventSubscriptionViewController {
            
            userSubscribe.currentEvent = self.viewModel.currentEvent
            userSubscribe.currentSubgroup = self.viewModel.subgroup.grupo
            userSubscribe.currentUser = viewModel.currentUser
            
            navigationController?.pushViewController(userSubscribe, animated: true)
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
        self.viewModel.subgroup.grupo = viewModel.currentEvent.subgrupos[row].grupo
        eventSubGroupVacanciesLabel.text = String(vacancy)
        self.availabilityToSubscribe()
    }
    
}

extension User_EventViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if viewModel.currentEvent.subgrupos != nil &&
            (viewModel.currentEvent.subgrupos.count) > 0  {
            return (viewModel.currentEvent.subgrupos.count)
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if viewModel.currentEvent.subgrupos.count > 0 {
            let group = viewModel.currentEvent.subgrupos[row].grupo
            self.viewModel.subgroup.grupo = group
            return group
        }
        return self.viewModel.subgroup.grupo
    }
}


