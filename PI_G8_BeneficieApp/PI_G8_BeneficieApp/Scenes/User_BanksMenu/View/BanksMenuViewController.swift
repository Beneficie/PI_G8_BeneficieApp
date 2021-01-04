//
//  BanksMenuViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 23/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class BanksMenuViewController: UIViewController {
    
    @IBOutlet var collectionViewBanks: UICollectionView!
    var arrayBanks = [BankAccount]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewBanks.delegate = self
        collectionViewBanks.dataSource = self

        arrayBanks.append(BankAccount(name: "PIX", photo: "PIX", agency: "", accountType: "Conta Corrente", accountNumber: "", accountBeneficited: ""))
        arrayBanks.append( BankAccount(name: "Santander", photo: "BancoSantander", agency: "", accountType: "Conta ", accountNumber: "", accountBeneficited: "Mudadores"))
        arrayBanks.append(BankAccount(name: "Nubank", photo: "BancoNubank", agency: "0001", accountType: "Conta Corrente", accountNumber: "000000-1", accountBeneficited: "Mudadores"))
        arrayBanks.append(BankAccount(name: "Inter", photo: "BancoInter", agency: "BancoInter", accountType: "Conta ", accountNumber: "", accountBeneficited: "Mudadores"))
        arrayBanks.append(BankAccount(name: "Bradesco", photo: "BancoBradesco", agency: "3142-9", accountType: "Conta Poupança", accountNumber: "1001908-7", accountBeneficited: "Mudadores"))
        arrayBanks.append(BankAccount(name: "Banco do Brasil", photo: "BancoDoBrasil", agency: "1197-5", accountType: "Conta Corrente", accountNumber: "53923-6", accountBeneficited: "Mudadores"))
        arrayBanks.append(BankAccount(name: "Caixa", photo: "BancoCaixa", agency: "3205", accountType: "Conta Poupança", accountNumber: "34102-3 Operação: 013", accountBeneficited: "Mudadores"))
        arrayBanks.append(BankAccount(name: "Itaú", photo: "BancoItau", agency: "5488", accountType: "Conta ", accountNumber: "01610-5", accountBeneficited: "Mudadores"))
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func profileButton(_ sender: Any) {
        if let Profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController { navigationController?.pushViewController(Profile, animated: true) }
    }
    

}

extension BanksMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let financialDetails = UIStoryboard(name: "FinancialDetails", bundle: nil).instantiateInitialViewController() as? FinancialDetailsViewController {
            financialDetails.bank = arrayBanks[indexPath.row]
            present(financialDetails, animated: true, completion: nil)
        }
    }
}

extension BanksMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension BanksMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayBanks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankCell", for: indexPath) as! BankCell
        cell.setUpCell(bank: arrayBanks[indexPath.row])
        return cell
    }
    
    
}

