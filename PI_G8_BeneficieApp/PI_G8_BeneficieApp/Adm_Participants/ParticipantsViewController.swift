//
//  ParticipantsViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 22/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class ParticipantsViewController: UIViewController {

    @IBOutlet weak var ParticipantsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParticipantsTableView.delegate = self
        ParticipantsTableView.dataSource = self
    }
    
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func profilleButton(_ sender: Any) {
        if let Profile = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            navigationController?.pushViewController(Profile, animated: true)
        }
    }
    
}

//MARK: - TableViewDelegate and DataSource

extension ParticipantsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! ParticipantsCell
        cell.configure(with: ParticipantsModel(name: "Antonio Guilherme"))
        return cell
    }
    
    
}
