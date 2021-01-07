//
//  CreateActionViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 22/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class CreateActionViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldEventTitle: UITextField!
    @IBOutlet weak var textFieldTotal: UITextField!
    @IBOutlet weak var textFieldGroups: UITextField!
    @IBOutlet weak var textFieldAvailable: UITextField!
    @IBOutlet weak var textFieldEventDescription: UITextField!
    
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    
    var currentAction: String = "Criar"
    var currentEvent = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        if currentAction.lowercased() == "editar" {
            editEvent()
        }
    }
    
    func configureUI(){
        //ActionContainer.setupShadow(opacity: 0.2, radius: 4)
        saveButtonOutlet.layer.cornerRadius = 15
        labelTitle.text = "\(currentAction) Ação"
        
    }
    
    func editEvent() {
//        datePicker.date = currentEvent.data
        textFieldAddress.text = currentEvent.local
        textFieldEventTitle.text = currentEvent.titulo
        textFieldTotal.text = String(currentEvent.vagasTotais)
        textFieldGroups.text = String(currentEvent.subgrupos.count)
        textFieldAvailable.text = String(currentEvent.vagasDisponiveis)
        textFieldEventDescription.text = currentEvent.descricao
    }
    @IBAction func actionDatePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
    }
    
    @IBAction func profileButton(_ sender: Any) {
        if let Profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            navigationController?.pushViewController(Profile, animated: true)
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Ação Salva", message: "Ação salva com sucesso", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
