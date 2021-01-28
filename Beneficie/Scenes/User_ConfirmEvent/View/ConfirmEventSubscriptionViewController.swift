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
    @IBOutlet var textFieldFullName: UITextField!
    @IBOutlet var textFieldContact: UITextField!
    @IBOutlet var buttonConfirm: UIButton!
    
    var viewModel = ConfirmEventSubscriptionViewModel()
    var currentEvent = Event()
    var currentUser = User()
    var currentSubgroup = ""
    
    func openFinancialScreen() {
        if let userFinanceData = UIStoryboard(name: "BanksMenu", bundle: nil).instantiateInitialViewController() as? BanksMenuViewController {
            navigationController?.pushViewController(userFinanceData, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.currentEvent = currentEvent
        viewModel.currentUser = currentUser
        viewModel.currentSubgroup = currentSubgroup
        
        setUpUI()
        
    }
    
    func setUpUI() {
        textFieldFullName.delegate = self
        textFieldContact.delegate = self
        labelEventTitle.text = self.viewModel.currentEvent.titulo
        labelSubgroup.text = "Subgrupo \(viewModel.currentSubgroup)"
        buttonConfirm.layer.cornerRadius = 15
        textFieldContact.text = viewModel.currentUser.phoneNumber
    }
    
    func showAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: cancelHandler))
        present(alert, animated: true, completion: nil)
    }
    

    
    func subscribeUser() {
        viewModel.checkUser(name: self.textFieldFullName.text!, phoneNumber: self.textFieldContact.text!)
        if let index = viewModel.currentEvent.subgrupos.firstIndex(where: { $0.grupo == viewModel.currentSubgroup }) {
            viewModel.currentEvent.subgrupos[index].inscritos.append(viewModel.currentUser.uid)
//            viewModel.currentUser.phoneNumber = textFieldContact.text
            viewModel.currentEvent.subgrupos[index].vagasDisponiveisSubgrupo -= 1
            viewModel.subscribeUser(event: viewModel.currentEvent) { (success) in
                if success {
                    self.showAlert(title: "Inscrição Confirmada", message: "Você foi inscrito na ação", okHandler: {_ in
                        self.viewModel.saveNewEventToDataBase(eventName: self.viewModel.currentEvent.titulo,
                                                              eventDate: self.viewModel.currentEvent.data,
                                                              eventAddress: self.viewModel.currentEvent.local,
                                                              eventDescription: self.viewModel.currentEvent.descricao,
                                                              eventSubgroup: self.viewModel.currentSubgroup)
                        self.viewModel.newRootController()
                        self.openFinancialScreen()
                    }, cancelHandler: nil)
                } else {
                    self.showAlert(title: "Erro", message: "Não foi possível realizar inscrição", okHandler: nil, cancelHandler: nil)
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func profileButton(_ sender: Any) {
        self.viewModel.goToProfileScreen(navigationController: self.navigationController)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        self.subscribeUser()
    }
    

}

extension ConfirmEventSubscriptionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else if textField == textFieldFullName {
            textFieldFullName.resignFirstResponder()
            textFieldContact.becomeFirstResponder()
            return true
        }else if textField == textFieldContact {
            textFieldContact.resignFirstResponder()
            self.subscribeUser()
            return true
        }else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil {
            self.showAlert(title: "Preencha os campos", message: "", okHandler: nil, cancelHandler: nil)
        }
    }
}
