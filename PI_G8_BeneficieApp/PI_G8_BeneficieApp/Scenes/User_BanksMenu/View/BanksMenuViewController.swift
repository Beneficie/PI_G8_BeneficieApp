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
    var viewModel = BanksMenuViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewBanks.delegate = self
        collectionViewBanks.dataSource = self

        
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func profileButton(_ sender: Any) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController { navigationController?.pushViewController(profile, animated: true) }
    }
    

}

extension BanksMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let financialDetails = UIStoryboard(name: "FinancialDetails", bundle: nil).instantiateInitialViewController() as? FinancialDetailsViewController {
            financialDetails.bank = viewModel.arrayBanks[indexPath.row]
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
        return viewModel.arrayBanks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankCell", for: indexPath) as! BankCell
        cell.setUpCell(bank: viewModel.arrayBanks[indexPath.row])
        return cell
    }
    
    
}

