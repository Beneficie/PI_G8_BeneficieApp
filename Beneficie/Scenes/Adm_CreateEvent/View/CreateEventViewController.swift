//
//  CreateEventViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 22/11/20.
//

import UIKit

class CreateEventViewController: UIViewController {

    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventTotalVacancyTextField: UITextField!
    @IBOutlet weak var groupsNumberTextField: UITextField!
    @IBOutlet weak var groupVacancyLabel: UILabel!
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var currentActionLabel: UILabel!
    
    var viewModel = CreateEventViewModel()
    var currentAction: Action = .criar
    var currentEvent = EventADM()
    var currentUser = User()
    
    var arrayPickerView = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressTextField.delegate = self
        eventTitleTextField.delegate = self
        eventTotalVacancyTextField.delegate = self
        groupsNumberTextField.delegate = self
        eventDescriptionTextField.delegate = self
        
        configureUI()
        
    }
    
    enum Action: String {
        case editar = "editar"
        case criar = "criar"
    }
    
    func showAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        present(alert, animated: true, completion: nil)
    }
    
    func handleGroupDivision() {
        if let groups = Int(groupsNumberTextField.text!), let totalVacancy = Int(eventTotalVacancyTextField.text!) {
            let vacancy = viewModel.handleVacancy(totalVacancy: totalVacancy, groupCount: groups)
            groupVacancyLabel.text = String(vacancy)
        }

    }
        
    func createEvent() {
        if let address = addressTextField.text,
           let title = eventTitleTextField.text,
           let totalVacancy = eventTotalVacancyTextField.text,
           let groups = groupsNumberTextField.text,
           let eventDescription = eventDescriptionTextField.text {
            let newEvent = viewModel.getEvent(address: address, title: title, totalVacancy: Int(totalVacancy)!, eventDescription: eventDescription, groupCount: Int(groups)!)
            viewModel.createEvent(event: newEvent) { (success) in
                if success {
                    self.showAlert(title: "Ação Salva", message: "Ação salva com sucesso", okHandler: { ok in
                        self.viewModel.goToEventListScreen(user: self.currentUser, navigationController: self.navigationController)
                    })
                } else {
                    self.showAlert(title: "Não foi possível", message: "Erro ao criar evento", okHandler: nil)
                }
            }
        } else {
            showAlert(title: "Erro", message: "Preencha todos os campos", okHandler: nil)
        }
    }
    
    func configureUI(){
        saveButton.layer.cornerRadius = 15
        if currentAction == .editar {
            currentActionLabel.text = "Editar Ação"
            fillTextFieldInEditAction()
        }
        
    }
    
    func fillTextFieldInEditAction() {
        eventDatePicker.setDate(Date(), animated: true)
        addressTextField.text = currentEvent.local
        eventTitleTextField.text = currentEvent.titulo
        eventTotalVacancyTextField.text = String(currentEvent.vagasTotais)
        groupVacancyLabel.text = String(currentEvent.vagasDisponiveis)
        eventDescriptionTextField.text = currentEvent.descricao
    }
    
    func editEvent(eventId: String) {
        if let address = addressTextField.text,
           let title = eventTitleTextField.text,
           let totalVacancy = eventTotalVacancyTextField.text,
           let groups = groupsNumberTextField.text,
           let eventDescription = eventDescriptionTextField.text {
            self.viewModel.editEvent(eventId: eventId,
                address: address,
                title: title,
                totalVacancy: Int(totalVacancy)!,
                groups: Int(groups)!,
                eventDescription: eventDescription) { (success) in
                if success {
                    self.showAlert(title: "Sucesso", message: "Evento Atualizado", okHandler: { ok in
                            self.viewModel.goToEventListScreen(user: self.currentUser, navigationController: self.navigationController)
                    })
                } else {
                    self.showAlert(title: "Erro", message: "Não foi possível atualizar o evento", okHandler: nil)
                }
            }
        }
        
    }
    
    @IBAction func datePickerFormatter(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let eventDate = dateFormatter.string(from: eventDatePicker.date)
        viewModel.newEvent.data = eventDate
    }
    
    @IBAction func profileButton(_ sender: Any) {
        self.viewModel.goToProfileScreen(user: currentUser, navigationController: self.navigationController)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if let eventId = currentEvent._id {
            if currentAction == .editar {
                editEvent(eventId: eventId)
            }
        } else {
            createEvent()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CreateEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else if textField == addressTextField {
            textField.resignFirstResponder()
            eventTitleTextField.becomeFirstResponder()
            return true
        } else if textField == eventTitleTextField {
            textField.resignFirstResponder()
            eventTotalVacancyTextField.becomeFirstResponder()
            return true
        } else if textField == eventTotalVacancyTextField {
            textField.resignFirstResponder()
            groupsNumberTextField.becomeFirstResponder()
            return true
        } else if textField == groupsNumberTextField {
            textField.resignFirstResponder()
            eventDescriptionTextField.becomeFirstResponder()
            return true
        } else if textField == eventDescriptionTextField {
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if groupsNumberTextField != nil, eventTotalVacancyTextField != nil {
            handleGroupDivision()
        }
    }
}

