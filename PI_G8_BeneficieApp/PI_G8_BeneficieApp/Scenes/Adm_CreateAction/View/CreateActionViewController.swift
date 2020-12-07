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
    @IBOutlet weak var actionContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func configureUI(){
        //ActionContainer.setupShadow(opacity: 0.2, radius: 4)
        saveButtonOutlet.layer.cornerRadius = 15
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
