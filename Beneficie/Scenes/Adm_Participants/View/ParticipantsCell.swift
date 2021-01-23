//
//  ParticipantsCell.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 22/11/20.
//

import UIKit

class ParticipantsCell: UITableViewCell{
    
    @IBOutlet weak var participantLabel: UILabel!
    
    func configure(name: String){
        participantLabel.text = name
    }
}

struct ParticipantsModel{
    var name: String?
}
