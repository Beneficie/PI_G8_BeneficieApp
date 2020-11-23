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
    var arrayBanks = [Bank]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewBanks.delegate = self
        collectionViewBanks.dataSource = self

        arrayBanks.append(Bank(name: "Pix", photo: "PIX"))
        arrayBanks.append(Bank(name: "Santander", photo: "BancoSantander"))
        arrayBanks.append(Bank(name: "Nubank", photo: "BancoNubank"))
        arrayBanks.append(Bank(name: "Inter", photo: "BancoInter"))
        arrayBanks.append(Bank(name: "Bradesco", photo: "BancoBradesco"))
        arrayBanks.append(Bank(name: "Banco do Brasil", photo: "BancoDoBrasil"))
        arrayBanks.append(Bank(name: "Caixa", photo: "BancoCaixa"))
        arrayBanks.append(Bank(name: "Itau", photo: "BancoItau"))
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}

extension BanksMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let financialDetails = UIStoryboard(name: "FinancialDetails", bundle: nil).instantiateInitialViewController() as? FinancialDetailsViewController {
            present(financialDetails, animated: true, completion: nil)
        }
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
