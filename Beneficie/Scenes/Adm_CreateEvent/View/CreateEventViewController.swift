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
    var newEvent = Event()
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
    
    func handleVacancy() {
        if addressTextField.text != nil,
        eventTitleTextField.text != nil,
        eventTotalVacancyTextField.text != nil,
        groupsNumberTextField.text != nil,
        eventDescriptionTextField.text != nil {
            if eventTotalVacancyTextField.text!.isEmpty == false,
               groupsNumberTextField.text!.isEmpty == false {
                if let totalVacancy = eventTotalVacancyTextField.text,
                   let groupVacancy = groupsNumberTextField.text {
                    if groupVacancy == "1" {
                        eventTotalVacancyTextField.text = groupVacancy
                    } else {
                        let result = Int(totalVacancy)!/Int(groupVacancy)!
                        groupVacancyLabel.text = String(result)
                    }
                }
            }
        }
    }
    
    func createEvent() {
        if let address = addressTextField.text,
           let title = eventTitleTextField.text,
           let totalVacancy = eventTotalVacancyTextField.text,
           let groups = groupsNumberTextField.text,
           let eventDescription = eventDescriptionTextField.text
        {
            if addressTextField.text?.isEmpty == false,
               eventTitleTextField.text?.isEmpty == false,
               eventTotalVacancyTextField.text?.isEmpty == false,
               groupsNumberTextField.text?.isEmpty == false,
               eventDescriptionTextField.text?.isEmpty == false
            {
                newEvent.local = address
                newEvent.titulo = title
                newEvent.vagasTotais = Int(totalVacancy)!
                newEvent.descricao = eventDescription
                let groupsCount = Int(groups)!
                var subgroups = [Subgroup]()
                for groupIndex in 1...groupsCount {
                    var subgroup = Subgroup()
                    subgroup.grupo = "Grupo \(groupIndex)"
                    subgroup.vagasSubgrupo = Int(totalVacancy)!/Int(groups)!
                    subgroup.vagasDisponiveisSubgrupo = subgroup.vagasSubgrupo
                    subgroups.append(subgroup)
                }
                newEvent.subgrupos = subgroups
                viewModel.createEvent(event: newEvent) { (success) in
                    if success {
                        let alert = UIAlertController(title: "Ação Salva", message: "Ação salva com sucesso", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                            if let main = UIStoryboard(name: "EventList", bundle: nil).instantiateInitialViewController() as? EventListViewController {
                                main.loadData()
                                self.navigationController?.pushViewController(main, animated: true)
                            }

                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Não foi possível", message: "Erro ao criar evento", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Erro", message: "Preencha todos os campos", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                
                        }))
                        present(alert, animated: true)
            }
            
        }
    }
    
    func configureUI(){
        //ActionContainer.setupShadow(opacity: 0.2, radius: 4)
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
        newEvent.data = eventDate
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
        handleVacancy()
    }
}

