//
//  User_InformacoesFinanceirasViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//

import UIKit
import ICConfetti

class FinancialDetailsViewController: UIViewController {

    @IBOutlet weak var choosenBankNameLabel: UILabel!
    @IBOutlet weak var choosenBankAgencyLabel: UILabel!
    @IBOutlet weak var choosenBankAccountTypeLabel: UILabel!
    @IBOutlet weak var choosenBankAccountLabel: UILabel!
    @IBOutlet weak var choosenBankBenefitedLabel: UILabel!
    @IBOutlet weak var bankTitleLabel: UILabel!
    @IBOutlet weak var agencyTitleLabel: UILabel!
    @IBOutlet weak var benefitedTitleLabel: UILabel!
    @IBOutlet weak var bankNameClipboard: UIButton!
    @IBOutlet weak var bankAgencyClipboard: UIButton!
    @IBOutlet weak var bankAccountClipboard: UIButton!
    
    
    @IBOutlet weak var didDonateButton: UIButton!
    
    var viewModel = FinancialDetailsViewModel()
    var bank = BankAccount()
    
    var icConfetti = ICConfetti()
    
    func openSocialNetwork() -> UIView? {
        if let userSocialNetworks = UIStoryboard(name: "User_SocialNetworks", bundle: nil).instantiateInitialViewController() as? User_SocialNetworksViewController {
            present(userSocialNetworks, animated: true, completion: nil)
            return userSocialNetworks.view
        }
        return nil
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
            agencyTitleLabel.text = " Tipo de chave:  "
            choosenBankAgencyLabel.text = bank.accountBeneficited
            choosenBankAccountTypeLabel.text  = ""
            benefitedTitleLabel.text = ""
            choosenBankAccountLabel.text = ""
            choosenBankBenefitedLabel.text = ""
            bankNameClipboard.tintColor = UIColor.white
            bankAccountClipboard.tintColor = UIColor.white
            bankNameClipboard.isUserInteractionEnabled = false
            bankAccountClipboard.isUserInteractionEnabled = false
        }
    }
    
    func alertDonation() {
        let alert = UIAlertController(title: "Doação", message: "Deseja marcar como doado?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Realizei Doação", style: .default, handler: {_ in
            if let nextScreen = self.openSocialNetwork() {
                self.icConfetti.rain(in: nextScreen)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: {_ in
        }))
        present(alert, animated: true)

    }
    
    func setupUI() {
        didDonateButton.layer.cornerRadius = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpLabels(bank: self.bank)
        self.setupUI()
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
    
    @IBAction func didDonate(_ sender: Any) {
        self.alertDonation()
    }
    
}
