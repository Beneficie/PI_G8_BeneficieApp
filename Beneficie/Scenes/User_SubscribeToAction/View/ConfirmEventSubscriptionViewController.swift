//
//  ConfirmEventSubscriptionViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 23/11/20.
//

import UIKit

class ConfirmEventSubscriptionViewController: UIViewController {

    @IBOutlet var labelSubgroup: UILabel!
    @IBOutlet var labelEventTitle: UILabel!
    @IBOutlet var textFieldContact: UITextField!
    @IBOutlet var buttonConfirm: UIButton!
    
    var currentEvent = Event()
    var currentUser = User()
    var currentSubgroup: String = ""
    var viewModel = ConfirmEventSubscriptionViewModel()
    
    func openFinancialScreen() {
        if let userFinanceData = UIStoryboard(name: "BanksMenu", bundle: nil).instantiateInitialViewController() as? BanksMenuViewController {
            navigationController?.pushViewController(userFinanceData, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        labelEventTitle.text = currentEvent.titulo
        labelSubgroup.text = "Subgrupo \(currentSubgroup)"
        buttonConfirm.layer.cornerRadius = 15
        textFieldContact.text = currentUser.telefone
    }
    
    func subscribeUser() {
        if let index = currentEvent.subgrupos.firstIndex(where: { $0.grupo == currentSubgroup }) {
            currentEvent.subgrupos[index].inscritos.append(currentUser.nome)
            currentEvent.subgrupos[index].vagasDisponiveisSubgrupo -= 1
            viewModel.subscribeUser(event: currentEvent) { (success) in
                if success {
                    let alert = UIAlertController(title: "Inscrição Confirmada", message: "Você foi inscrito na ação", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                        self.viewModel.saveNewEventToDataBase(eventName: self.currentEvent.titulo,
                                                              eventDate: self.currentEvent.data,
                                                              eventAddress: self.currentEvent.local,
                                                              eventDescription: self.currentEvent.descricao,
                                                              eventSubgroup: self.currentSubgroup)
                        self.viewModel.getCoreDataDBPath()
                        self.openFinancialScreen()
                    }))
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Erro", message: "Não foi possível realizar inscrição", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                    }))
                    self.present(alert, animated: true)
                }
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
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        self.subscribeUser()
    }
    

}
