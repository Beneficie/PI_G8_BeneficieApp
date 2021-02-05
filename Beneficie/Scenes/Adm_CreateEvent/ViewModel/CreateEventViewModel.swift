//
//  CreateEventViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import UIKit

class CreateEventViewModel {
    
    var apiManager = APIManager()
    
    func createEvent(event: Event, onComplete: @escaping (Bool) -> Void) {
        apiManager.createEvent(event: event) { isOk in
            onComplete(isOk)
        }
    }
    
    func goToProfileScreen(user: User, navigationController: UINavigationController?) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            profile.currentUser = user
            navigationController?.pushViewController(profile, animated: true) }
    }
    
    
}
