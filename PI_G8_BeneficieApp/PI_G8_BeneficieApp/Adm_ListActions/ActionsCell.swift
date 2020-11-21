//
//  ActionsCell.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 21/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class ActionsCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func setup(with model: actionsModel){
        dateLabel.text = model.date
        nameLabel.text = model.name
    }
}

struct actionsModel{
    var date: String?
    var name: String?
}
