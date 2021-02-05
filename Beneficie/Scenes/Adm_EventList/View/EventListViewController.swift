//
//  EventListViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 22/11/20.
//

import UIKit

class EventListViewController: UIViewController {

    var viewModel = EventListViewModel()
    
    @IBOutlet var eventListTableView: UITableView!
    @IBOutlet weak var createEventButton: UIButton!
    
    var event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
        
        loadData()
        
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        viewModel.loadData { success in
            if success {
                self.eventListTableView.reloadData()
                self.event = self.viewModel.arrayEvents[0]
//                print("Success")
//                self.setUpUI(event: self.event)
            } else {
                print("Error: LoadData from eventList")
//                self.alertFailedInLoadData()
            }
        }
    }
    
    func configureUI(){
        //ActionContainer.setupShadow(opacity: 0.2, radius: 4)
        createEventButton.layer.cornerRadius = 15
        createEventButton.layer.cornerRadius = 15
    }
    @IBAction func profileButton(_ sender: Any) {
        if let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            navigationController?.pushViewController(profile, animated: true)
        }
    }
    @IBAction func createEvent(_ sender: Any) {
        if let newEvent = UIStoryboard(name: "CreateEvent", bundle: nil).instantiateInitialViewController() as? CreateEventViewController {
            navigationController?.pushViewController(newEvent, animated: true)
        }
    }
    
    func bankInformationsScreen() {
        if let banks = UIStoryboard(name: "BankInformations", bundle: nil).instantiateInitialViewController() as? BankInformationsViewController {
            navigationController?.pushViewController(banks, animated: true)
        }
    }
    
    func participantsListScreen(event: Event) {
        if let list = UIStoryboard(name: "ParticipantsList", bundle: nil).instantiateInitialViewController() as? ParticipantsViewController {
            list.event = event
            navigationController?.pushViewController(list, animated: true)
        }
    }
    
    func editEvent(event: Event) {
        if let newEvent = UIStoryboard(name: "CreateEvent", bundle: nil).instantiateInitialViewController() as? CreateEventViewController {
            newEvent.currentAction = "Editar"
            newEvent.currentEvent = event
            navigationController?.pushViewController(newEvent, animated: true)
        }
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        eventListTableView.deselectRow(at: indexPath, animated: true)
        if editingStyle == .delete {
            viewModel.arrayEvents.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Evento", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Editar Ação", style: .default, handler: {_ in
            self.editEvent(event: self.viewModel.arrayEvents[indexPath.row])
        }))
        alert.addAction(UIAlertAction(title: "Informações Bancárias", style: .default, handler: {_ in
            self.bankInformationsScreen()
        }))
        alert.addAction(UIAlertAction(title: "Participantes Cadastrados", style: .default, handler: {_ in
            self.participantsListScreen(event: self.viewModel.arrayEvents[indexPath.row])
        }))
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive, handler: {_ in
            self.viewModel.arrayEvents.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: {_ in
        }))
        present(alert, animated: true)
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = viewModel.arrayEvents[indexPath.row].titulo
        return cell
    }
    
    
}