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
    var subgroup = SubgroupADM()
    
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
        self.viewModel.goToProfileScreen(user: currentUser, navigationController: self.navigationController)
    }
    
}

//MARK: - TableViewDelegate and DataSource
extension ParticipantsViewController: UITableViewDelegate {}


extension ParticipantsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getParticipantsList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! ParticipantsCell
        cell.configure(name: getParticipantsList()[indexPath.row])
        return cell
    }
    
    
}
