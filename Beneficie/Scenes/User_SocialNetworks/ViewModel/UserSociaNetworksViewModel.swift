//
//  UserSociaNetworksViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//

import Foundation
import UIKit

class UserSociaNetworksViewModel {
    
    let userURL = "mudadoresderua"
    
    func goToLink(link: String) {
        guard let url = URL(string: "https://\(link).com/\(userURL)")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func goToInstagramProfile() {
        goToLink(link: "instagram")
    }
    
    func goToFacebookProfile() {
        goToLink(link: "facebook")
    }
    
    func goToTwitterProfile() {
        goToLink(link: "twitter")
    }
    
    func shareDonation() -> UIActivityViewController {
        let string = "Veja como foi fácil ajudar essa causa!"
        let url = URL(string: "https:")!
        let image = UIImage(named: "")
        let pdf = Bundle.main.url(forResource: "xx",
                                  withExtension: "pdf")
        
        let activityViewController =
            UIActivityViewController(activityItems: [string, url, image, pdf],
                                     applicationActivities: nil)
        
        return activityViewController
    }
}
