//
//  ParticipantsViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation

class ParticipantsViewModel {
    
    var arrayUsersSubscribed = [UserSubscribed]()
    

    
    func getNumberofRows() -> Int {
        return arrayUsersSubscribed.count
    }
}
