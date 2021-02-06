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
    
    var newEvent = EventADM()
    
    func getEvent(address: String, title: String, totalVacancy: Int, description: String, groupCount: Int) -> Event {
        var newEvent = Event()
        newEvent.local = address
        newEvent.titulo = title
        newEvent.vagasTotais = totalVacancy
        newEvent.descricao = description
        let groupsCount = groupCount
        var subgroups = [Subgroup]()
        for groupIndex in 1...groupsCount {
            var subgroup = Subgroup()
            subgroup.grupo = "Grupo \(groupIndex)"
            subgroup.vagasSubgrupo = totalVacancy/groupsCount
            subgroup.vagasDisponiveisSubgrupo = subgroup.vagasSubgrupo
            subgroups.append(subgroup)
        }
        newEvent.subgrupos = subgroups
        return newEvent
    }
    
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
    
    func handleVacancy(totalVacancy: Int, groupCount: Int) -> Int {
        let result = totalVacancy/groupCount
        return result
    }
    
    
}
