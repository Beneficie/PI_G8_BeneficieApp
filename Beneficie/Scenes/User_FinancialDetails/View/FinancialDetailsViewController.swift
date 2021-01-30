//
//  User_InformacoesFinanceirasViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//

import UIKit

class FinancialDetailsViewController: UIViewController {

    @IBOutlet weak var choosenBankNameLabel: UILabel!
    @IBOutlet weak var choosenBankAgencyLabel: UILabel!
    @IBOutlet weak var choosenBankAccountTypeLabel: UILabel!
    @IBOutlet weak var choosenBankAccountLabel: UILabel!
    @IBOutlet weak var choosenBankBenefitedLabel: UILabel!
    @IBOutlet weak var bankTitleLabel: UILabel!
    @IBOutlet weak var agencyTitleLabel: UILabel!
    @IBOutlet weak var benefitedTitleLabel: UILabel!
    
    
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
            choosenBankNameLabel.text = bank.name
            choosenBankAgencyLabel.text  = bank.agency
            choosenBankAccountTypeLabel.text  = bank.accountType
            choosenBankAccountLabel.text = bank.accountNumber
            choosenBankBenefitedLabel.text = bank.accountBeneficited
        } else {
            bankTitleLabel.text = "Chave Pix"
            choosenBankNameLabel.text = bank.name
            agencyTitleLabel.text = bank.accountBeneficited
            choosenBankAgencyLabel.text = ""
            choosenBankAccountTypeLabel.text  = ""
//            accountTitle.text = ""
            benefitedTitleLabel.text = ""
            choosenBankAccountLabel.text = ""
            choosenBankBenefitedLabel.text = ""
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
        pasteboard.string = choosenBankNameLabel.text
    }
    @IBAction func copyAgency(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = choosenBankAgencyLabel.text
    }
    @IBAction func copyAccount(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = choosenBankAccountLabel.text
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
