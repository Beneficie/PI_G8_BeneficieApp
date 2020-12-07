//
//  ParticipantsCell.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 22/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class ParticipantsCell: UITableViewCell{
    
    @IBOutlet weak var participantLabel: UILabel!
    
    func configure(with model: ParticipantsModel){
        participantLabel.text = model.name
    }
}

struct ParticipantsModel{
    var name: String?
}
