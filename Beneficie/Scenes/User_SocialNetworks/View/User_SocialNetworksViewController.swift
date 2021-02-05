//
//  User_InformacoesFinanceirasViewController.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 12/11/20.
//

import UIKit

class User_SocialNetworksViewController: UIViewController {

    @IBOutlet weak var twitterImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        twitterImage.layer.cornerRadius = 15
//        shareButton.layer.cornerRadius = 15
//        shareButton.layer.borderWidth = 2
//        shareButton.layer.borderColor = CGColor(red: 115/255, green: 121/255, blue: 224/255, alpha: 1.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func instagramButtonTapped(_ sender: Any) {
        let userURL = "mudadoresderua"
        guard let url = URL(string: "https://instagram.com/\(userURL)")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func facebookButtonTapped(_ sender: Any) {
        let userURL = "mudadoresderua"
        guard let url = URL(string: "https://facebook.com/\(userURL)")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func twitterButtonTapped(_ sender: Any) {
        let userURL = "mudadoresderua"
        guard let url = URL(string: "https://twitter.com/\(userURL)")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
