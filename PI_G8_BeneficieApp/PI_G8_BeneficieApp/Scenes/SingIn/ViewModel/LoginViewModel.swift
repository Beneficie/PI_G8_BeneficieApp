//
//  LoginViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    var arrayUsers = [User]()
    
    var apiManager = APIManager()
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
        apiManager.requestArray(
            url: "https://beneficie-app.herokuapp.com/beneficie/users/") { (responseArray) in
            var users = [User]()
            for item in responseArray {
                users.append(User(fromDictionary: item as! [String : Any]))
            }
            self.arrayUsers = users
            onComplete(true)
            return
                onComplete(true)
        }
        onFailure: { (error) in
            print("Error \(error)")
            onComplete(false)
        }
    }
}
