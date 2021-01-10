//
//  CreateActionViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation

class CreateActionViewModel {
    
    var apiManager = APIManager()
    
    func createEvent(event: Event, onComplete: @escaping (Bool) -> Void) {
        apiManager.createEvent(event: event) { isOk in
            onComplete(isOk)
        }
    }
    
    
}
