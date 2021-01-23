//
//  BankCell.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 23/11/20.
//

import UIKit

class BankCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewBank: UIImageView!
    
    func setUpCell(bank: BankAccount?) {
        if let bank = bank {
            imageViewBank.image = UIImage(named: bank.photo!)
        }
    }
}
