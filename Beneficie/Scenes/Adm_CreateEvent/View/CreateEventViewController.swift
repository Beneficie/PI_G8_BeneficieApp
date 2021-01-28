//
//  CreateEventViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 22/11/20.
//

import UIKit

class CreateEventViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldEventTitle: UITextField!
    @IBOutlet weak var textFieldTotal: UITextField!
    @IBOutlet weak var textFieldGroups: UITextField!
    @IBOutlet weak var labelGroupVacancy: UILabel!
    @IBOutlet weak var textFieldEventDescription: UITextField!
    
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    
    var viewModel = CreateEventViewModel()
    var currentAction: String = "Criar"
    var currentEvent = Event()
    var newEvent = Event()
    var arrayPickerView = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldAddress.delegate = self
        textFieldEventTitle.delegate = self
        textFieldTotal.delegate = self
        textFieldGroups.delegate = self
        textFieldEventDescription.delegate = self
        
        configureUI()
        
        if currentAction.lowercased() == "editar" {
            editEvent()
        }

    }
    
    func handleVacancy() {
        if textFieldAddress.text != nil,
        textFieldEventTitle.text != nil,
        textFieldTotal.text != nil,
        textFieldGroups.text != nil,
        textFieldEventDescription.text != nil {
            if textFieldTotal.text!.isEmpty == false,
               textFieldGroups.text!.isEmpty == false {
                if let totalVacancy = textFieldTotal.text,
                   let groupVacancy = textFieldGroups.text {
                    if groupVacancy == "1" {
                        textFieldTotal.text = groupVacancy
                    } else {
                        let result = Int(totalVacancy)!/Int(groupVacancy)!
                        labelGroupVacancy.text = String(result)
                    }
                }
            }
        }
    }
    
    func createEvent() {
        if let address = textFieldAddress.text,
           let title = textFieldEventTitle.text,
           let totalVacancy = textFieldTotal.text,
           let groups = textFieldGroups.text,
           let eventDescription = textFieldEventDescription.text
        {
            if textFieldAddress.text?.isEmpty == false,
               textFieldEventTitle.text?.isEmpty == false,
               textFieldTotal.text?.isEmpty == false,
               textFieldGroups.text?.isEmpty == false,
               textFieldEventDescription.text?.isEmpty == false
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
        saveButtonOutlet.layer.cornerRadius = 15
        labelTitle.text = "\(currentAction) Ação"
        
    }
    
    func editEvent() {
        datePicker.setDate(Date(), animated: true)
        textFieldAddress.text = currentEvent.local
        textFieldEventTitle.text = currentEvent.titulo
        textFieldTotal.text = String(currentEvent.vagasTotais)
        labelGroupVacancy.text = String(currentEvent.vagasDisponiveis)
        textFieldEventDescription.text = currentEvent.descricao
    }
    @IBAction func datePickerFormatter(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let eventDate = dateFormatter.string(from: datePicker.date)
        newEvent.data = eventDate
    }
    
    @IBAction func profileButton(_ sender: Any) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            navigationController?.pushViewController(profile, animated: true)
        }
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
        if textFieldAddress != nil,
           textFieldAddress != nil,
           textFieldEventTitle != nil,
           textFieldTotal.text != nil
           {
            textFieldEventDescription.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        handleVacancy()
    }
}

