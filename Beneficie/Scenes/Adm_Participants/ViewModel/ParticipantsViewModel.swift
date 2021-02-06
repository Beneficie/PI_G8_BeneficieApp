//
//  ParticipantsViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import UIKit

class ParticipantsViewModel {
    
    var event = EventADM()
    var currentUser = User()
    var subgroup = SubgroupADM()
    
    func setupValues(currentUser: User, currentEvent: EventADM) {
        self.currentUser = currentUser
        self.event = currentEvent
    }
    
    func getParticipantsList() -> [String]? {
        var participants = [String]()
        for subgroup in event.subgrupos {
            participants.append(contentsOf: subgroup.inscritos.map({ (inscrito) -> String in
                if let volunteerName = inscrito.name {
                    return "\(volunteerName) - Subgrupo \(subgroup.grupo)"
                }
                return ""
            }
            ))
        }
        return participants
    }
    
//    func deleteUser(user: User, subgroup: Subgroup) {
//        
//    }
    
    func goToProfileScreen(user: User, navigationController: UINavigationController?) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            profile.currentUser = user
            navigationController?.pushViewController(profile, animated: true) }
    }
}
