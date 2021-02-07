//
//  FinancialDetailsViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import UIKit

class FinancialDetailsViewModel {
    
    func openSocialNetwork() -> UIViewController? {
        if let userSocialNetworks = UIStoryboard(name: "User_SocialNetworks", bundle: nil).instantiateInitialViewController() as? User_SocialNetworksViewController {
            return userSocialNetworks
        }
        return nil
    }
    
    
    
}
