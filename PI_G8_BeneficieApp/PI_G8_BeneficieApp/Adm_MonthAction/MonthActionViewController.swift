//
//  MonthActionViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 21/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class MonthActionViewController: UIViewController {

    @IBOutlet weak var purpleView: UIView!
  
    
    @IBOutlet weak var pinkView: UIView!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var FinancesContainer: UIView!
    @IBOutlet weak var ParticipantsContainer: UIView!
    @IBOutlet weak var ConfigureActionsContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureUI()
        
    }
    
    func configureUI(){
        purpleView.RoundView()
        pinkView.RoundView()
        whiteView.RoundView()
        
        FinancesContainer.setupShadow(opacity: 0.2, radius: 4)
        ParticipantsContainer.setupShadow(opacity: 0.2, radius: 4)
        ConfigureActionsContainer.setupShadow(opacity: 0.2, radius: 4)
    }
    
	
}
