//
//  BankCell.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 23/11/20.
//

import UIKit

class BankCell: UICollectionViewCell {
    
    @IBOutlet weak var bankImageView: UIImageView!
    
    func setUpCell(bank: BankAccount?) {
        if let bank = bank {
            bankImageView.image = UIImage(named: bank.photo!)
        }
    }
}
