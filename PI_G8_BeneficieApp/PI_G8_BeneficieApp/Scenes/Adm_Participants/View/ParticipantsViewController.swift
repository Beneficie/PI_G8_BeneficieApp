//
//  ParticipantsViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 22/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class ParticipantsViewController: UIViewController {

    var viewModel = ParticipantsViewModel()
    var event = Event()
//    var subgroup = Subgroup()
    
    func getParticipantsList() -> [String] {
        var participants = [String]()
        for subgroup in event.subgrupos {
            participants.append(contentsOf: subgroup.inscritos.map({ (inscrito) -> String in
                return "\(inscrito) - Subgrupo \(subgroup.grupo)"
            }
            ))
        }
        return participants
    }
    
    @IBOutlet weak var participantsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        participantsTableView.delegate = self
        participantsTableView.dataSource = self
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func profilleButton(_ sender: Any) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            navigationController?.pushViewController(profile, animated: true)
        }
    }
    
}

//MARK: - TableViewDelegate and DataSource
extension ParticipantsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        participantsTableView.deselectRow(at: indexPath, animated: true)
//        if editingStyle == .delete {
//            viewModel.arrayEvents.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
    }
}


extension ParticipantsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.getNumberofRows()
        return getParticipantsList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! ParticipantsCell
        cell.configure(name: getParticipantsList()[indexPath.row])
        return cell
    }
    
    
}
