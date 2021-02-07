//
//  EventListViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 22/11/20.
//

import UIKit
import FBSDKLoginKit

class EventListViewController: UIViewController {

    var viewModel = EventListViewModel()
    
    @IBOutlet var eventListTableView: UITableView!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var event = EventADM()
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
        
        loadData()
        
        configureUI()
        
        if let token = AccessToken.current, !token.isExpired {
            self.viewModel.userToken = token.tokenString
        }
    }
    
    func loadData() {
        loadingActivityIndicator.startAnimating()
        viewModel.getUserToken { (success) in
            if success {
                print(self.viewModel.currentUser.name)
                print("user loaded")
            } else {
                print("user loading fail")
            }
        }
        viewModel.loadData { success in
            if success {
                self.loadingActivityIndicator.stopAnimating()
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
        createEventButton.layer.cornerRadius = 15
        createEventButton.layer.cornerRadius = 15
    }
    
    func showAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        present(alert, animated: true, completion: nil)
    }
    
    func deleteEvent(indexPath: IndexPath, tableView: UITableView){
        self.viewModel.deleteEvent(event: self.viewModel.arrayEvents[indexPath.row], onComplete: { (success) in
            if success {
                self.viewModel.arrayEvents.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.showAlert(title: "Sucesso", message: "Evento Removido", okHandler: nil)
            } else {
                self.showAlert(title: "Erro", message: "Não foi possível remover o evento", okHandler: nil)
            }
        })
    }

    
    @IBAction func profileButton(_ sender: Any) {
        self.viewModel.goToProfileScreen(user: viewModel.currentUser, navigationController: self.navigationController)
    }
    
    @IBAction func createEvent(_ sender: Any) {
        self.viewModel.goToNewEventScreen(user: viewModel.currentUser, navigationController: self.navigationController)
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        eventListTableView.deselectRow(at: indexPath, animated: true)
        if editingStyle == .delete {
            deleteEvent(indexPath: indexPath, tableView: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Evento", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Editar Ação", style: .default, handler: {_ in
            self.viewModel.editEvent(event: self.viewModel.arrayEvents[indexPath.row],
                                     user: self.viewModel.currentUser,
                                     navigationController: self.navigationController)
        }))
        alert.addAction(UIAlertAction(title: "Informações Bancárias", style: .default, handler: {_ in
            self.viewModel.goToBankInformationsScreen(user: self.viewModel.currentUser,
                                                  navigationController: self.navigationController)
        }))
        alert.addAction(UIAlertAction(title: "Participantes Cadastrados", style: .default, handler: {_ in
            self.viewModel.goToParticipantsListScreen(event: self.viewModel.arrayEvents[indexPath.row],
                                                  user: self.viewModel.currentUser,
                                                  navigationController: self.navigationController)
        }))
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive, handler: {_ in
            self.deleteEvent(indexPath: indexPath, tableView: tableView)
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
