//
//  CreateActionViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 22/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class CreateActionViewController: UIViewController {

    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    
    var currentAction: String = "Criar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func configureUI(){
        //ActionContainer.setupShadow(opacity: 0.2, radius: 4)
        saveButtonOutlet.layer.cornerRadius = 15
        labelTitle.text = "\(currentAction) Ação"
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
