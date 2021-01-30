//
//  CreateEventViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation

class CreateEventViewModel {
    
    var apiManager = APIManager()
    
    func createEvent(event: Event, onComplete: @escaping (Bool) -> Void) {
        apiManager.createEvent(event: event) { isOk in
            onComplete(isOk)
        }
    }
    
    
}
