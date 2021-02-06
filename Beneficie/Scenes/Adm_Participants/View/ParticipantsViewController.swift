//
//  ParticipantsViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 22/11/20.
//

import UIKit

class ParticipantsViewController: UIViewController {
    
    var viewModel = ParticipantsViewModel()
    var event = EventADM()
    var currentUser = User()
    
    @IBOutlet weak var participantsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        participantsTableView.delegate = self
        participantsTableView.dataSource = self
        
        viewModel.setupValues(currentUser: currentUser, currentEvent: event)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func profilleButton(_ sender: Any) {
        self.viewModel.goToProfileScreen(user: viewModel.currentUser, navigationController: self.navigationController)
    }
    
}

//MARK: - TableViewDelegate and DataSource
extension ParticipantsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        participantsTableView.deselectRow(at: indexPath, animated: true)
//        if editingStyle == .delete {
//
//        }
//    }
}


extension ParticipantsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.subgroup.grupo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let participantsCount = viewModel.getParticipantsList()?.count {
            return participantsCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! ParticipantsCell
        if let cellTitle = viewModel.getParticipantsList()?[indexPath.row] {
            cell.configure(name: cellTitle)
            return cell
        } else {
            return cell
        }
    }
    
    
}
