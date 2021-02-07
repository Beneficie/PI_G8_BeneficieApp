//
//  BanksMenuViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 23/11/20.
//

import UIKit

class BanksMenuViewController: UIViewController {
    
    @IBOutlet var collectionViewBanks: UICollectionView!
    
    let selectedSpacingForSection: CGFloat = 8
    let heightForItem: CGFloat = 128
    let widthForItem: CGFloat = 128
    
    var currentUser = User()
    
    var viewModel = BanksMenuViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewBanks.delegate = self
        collectionViewBanks.dataSource = self

        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func profileButton(_ sender: Any) {
        viewModel.goToProfileScreen(user: currentUser, navigationController: self.navigationController) 
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
        return CGSize(width: widthForItem, height: heightForItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return selectedSpacingForSection
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

