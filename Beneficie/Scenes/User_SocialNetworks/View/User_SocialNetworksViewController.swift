//
//  User_InformacoesFinanceirasViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//

import UIKit
import ICConfetti

class User_SocialNetworksViewController: UIViewController {

    
    var viewModel = UserSociaNetworksViewModel()
    
    @IBOutlet weak var twitterImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    var icConfetti = ICConfetti()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        twitterImage.layer.cornerRadius = 15
        
        self.icConfetti.velocities = [128, 144, 128]
        self.icConfetti.rain(in: self.view)
    }
    
    @IBAction func instagramButtonTapped(_ sender: Any) {
        viewModel.goToInstagramProfile()
    }
    @IBAction func facebookButtonTapped(_ sender: Any) {
        viewModel.goToFacebookProfile()
    }
    @IBAction func twitterButtonTapped(_ sender: Any) {
        viewModel.goToTwitterProfile()
    }
    
    @IBAction func shareDonation(_ sender: Any) {
        let share = viewModel.shareDonation()
        present(share, animated: true) {}

    }
}

