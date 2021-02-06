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
    
    var currentEvent = EventADM()
    var newEvent = EventADM()
    
    func setupValues(currentEvent: EventADM) {
        self.currentEvent = currentEvent
    }
    
    
    
    func getEvent(address: String, title: String, totalVacancy: Int, eventDescription: String, groupCount: Int) -> EventADM {
        var newEvent = EventADM()
        newEvent.local = address
        newEvent.titulo = title
        newEvent.vagasTotais = totalVacancy
        newEvent.descricao = eventDescription
        let groupsCount = groupCount
        var subgroups = [SubgroupADM]()
        for groupIndex in 1...groupsCount {
            var subgroup = SubgroupADM()
            subgroup.grupo = "Grupo \(groupIndex)"
            subgroup.vagasSubgrupo = totalVacancy/groupsCount
            subgroup.vagasDisponiveisSubgrupo = subgroup.vagasSubgrupo
            subgroups.append(subgroup)
        }
        newEvent.subgrupos = subgroups
        return newEvent
    }
    
    func createEvent(event: EventADM, onComplete: @escaping (Bool) -> Void) {
        apiManager.createEvent(event: event) { isOk in
            onComplete(isOk)
        }
    }

    
    func editEvent(eventId: String, address: String, title: String, totalVacancy: Int, groups: Int, eventDescription: String, onComplete: @escaping (Bool) -> Void) {
        var newEvent = getEvent(address: address, title: title, totalVacancy: totalVacancy, eventDescription: eventDescription, groupCount: groups)
        newEvent._id = eventId
        apiManager.updateEvent(event: newEvent, onComplete: {(success) in
            if success {
                onComplete(true)
            }
        })
    }
    
    func goToProfileScreen(user: User, navigationController: UINavigationController?) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            profile.currentUser = user
            navigationController?.pushViewController(profile, animated: true) }
    }
    
    func goToEventListScreen(user: User, navigationController: UINavigationController?) {
        if let list = UIStoryboard(name: "EventList", bundle: nil).instantiateInitialViewController() as? EventListViewController {
            navigationController?.pushViewController(list, animated: true) }
    }
    
    func handleVacancy(totalVacancy: Int, groupCount: Int) -> Int {
        let result = totalVacancy/groupCount
        return result
    }
}
