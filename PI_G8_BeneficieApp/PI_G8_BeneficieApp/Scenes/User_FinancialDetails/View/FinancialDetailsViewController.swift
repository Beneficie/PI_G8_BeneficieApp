//
//  User_InformacoesFinanceirasViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class FinancialDetailsViewController: UIViewController {

    @IBOutlet weak var choosenBankName: UILabel!
    @IBOutlet weak var choosenBankAgency: UILabel!
    @IBOutlet weak var choosenBankAccountType: UILabel!
    @IBOutlet weak var choosenBankAccount: UILabel!
    @IBOutlet weak var choosenBankBenefited: UILabel!
    @IBOutlet weak var bankTitle: UILabel!
    @IBOutlet weak var agencyTitle: UILabel!
    @IBOutlet weak var benefitedTitle: UILabel!
    
    
    @IBOutlet weak var switchButton: UISwitch!
    
    var viewModel = FinancialDetailsViewModel()
    var bank = BankAccount()
    
    func openSocialNetwork() {
        if let userSocialNetworks = UIStoryboard(name: "User_SocialNetworks", bundle: nil).instantiateInitialViewController() as? User_SocialNetworksViewController {
            present(userSocialNetworks, animated: true, completion: nil)
        }
    }
    
    func setUpLabels(bank: BankAccount) {
        if bank.name?.lowercased() != "pix" {
            choosenBankName.text = bank.name
            choosenBankAgency.text  = bank.agency
            choosenBankAccountType.text  = bank.accountType
            choosenBankAccount.text = bank.accountNumber
            choosenBankBenefited.text = bank.accountBeneficited
        } else {
            bankTitle.text = "Chave Pix"
            choosenBankName.text = bank.name
            agencyTitle.text = bank.accountBeneficited
            choosenBankAgency.text = ""
            choosenBankAccountType.text  = ""
//            accountTitle.text = ""
            benefitedTitle.text = ""
            choosenBankAccount.text = ""
            choosenBankBenefited.text = ""
        }
    }
    
    func alertDonation() {
        let alert = UIAlertController(title: "Doação", message: "Deseja marcar como doado?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Realizei Doação", style: .default, handler: {_ in
            self.switchButton.isOn = true
            self.openSocialNetwork()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: {_ in
        }))
        present(alert, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpLabels(bank: self.bank)
        // Do any additional setup after loading the view.
    }
    @IBAction func copyBank(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = choosenBankName.text
    }
    @IBAction func copyAgency(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = choosenBankAgency.text
    }
    @IBAction func copyAccount(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = choosenBankAccount.text
    }
    
    @IBAction func switchDonation(_ sender: Any) {
        
        switch switchButton.isOn {
        case true:
            self.alertDonation()
        case false:
            self.openSocialNetwork()
        }
    }
    
}
