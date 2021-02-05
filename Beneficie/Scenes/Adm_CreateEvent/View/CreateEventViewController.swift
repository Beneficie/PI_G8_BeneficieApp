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
    var currentAction: String = "Criar"
    var currentEvent = Event()
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
        
        if currentAction.lowercased() == "editar" {
            editEvent()
        }

    }
    
    func showAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        present(alert, animated: true, completion: nil)
    }
        
    func createEvent() {
        if let address = addressTextField.text,
           let title = eventTitleTextField.text,
           let totalVacancy = eventTotalVacancyTextField.text,
           let groups = groupsNumberTextField.text,
           let eventDescription = eventDescriptionTextField.text {
            let newEvent = viewModel.getEvent(address: address, title: title, totalVacancy: Int(totalVacancy)!, description: description, groupCount: Int(groups)!)
            viewModel.createEvent(event: newEvent) { (success) in
                if success {
                    self.showAlert(title: "Ação Salva", message: "Ação salva com sucesso", okHandler: nil)
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
        currentActionLabel.text = "\(currentAction) Ação"
        
    }
    
    func editEvent() {
        eventDatePicker.setDate(Date(), animated: true)
        addressTextField.text = currentEvent.local
        eventTitleTextField.text = currentEvent.titulo
        eventTotalVacancyTextField.text = String(currentEvent.vagasTotais)
        groupVacancyLabel.text = String(currentEvent.vagasDisponiveis)
        eventDescriptionTextField.text = currentEvent.descricao
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
        createEvent()
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CreateEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if addressTextField != nil,
           addressTextField != nil,
           eventTitleTextField != nil,
           eventTotalVacancyTextField.text != nil
           {
            eventDescriptionTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let totalVacancy = eventTotalVacancyTextField.text,
           let groupsCount = groupsNumberTextField.text {
            let vacancypergroup = viewModel.handleVacancy(totalVacancy: Int(totalVacancy)!, groupCount: Int(groupsCount)!)
        }
    }
}

