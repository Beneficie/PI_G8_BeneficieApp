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
        
        
        apiManager.getAsArray(
            url: "https://beneficie-app.herokuapp.com/beneficie/users/") { (responseArray) in
            let decoder = JSONDecoder()
            
            do {
                let users = try decoder.decode([User].self, from: responseArray)
                self.arrayUsers = users
                onComplete(true)
                return
            }
            catch {
                print(error.localizedDescription)
                onComplete(false)
            }
            
        }
        onFailure: { (error) in
            print("Error \(error)")
            onComplete(false)
        }
    }
}
