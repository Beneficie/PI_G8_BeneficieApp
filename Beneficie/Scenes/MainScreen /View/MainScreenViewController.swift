//
//  MainScreenViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//

import UIKit
import FBSDKLoginKit

class MainScreenViewController: UIViewController {

    var viewModel = MainScreenViewModel()
    
    func handleTokenValue() {
        if viewModel.isTokenExpired() {
            viewModel.goToUserEventScreen(navigationController: self.navigationController)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleTokenValue()
        
    }
    
    @IBAction func goToADMFlow(_ sender: UIButton) {
        viewModel.goToUserAdministratorScreen(navigationController: self.navigationController)
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        viewModel.goToLoginScreen(navigationController: self.navigationController)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        viewModel.goToSignUp(navigationController: self.navigationController)
    }
    
}
