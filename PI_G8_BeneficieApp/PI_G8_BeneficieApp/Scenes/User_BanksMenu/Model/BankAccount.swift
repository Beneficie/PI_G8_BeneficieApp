//
//  BankAccount.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 30/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation

class BankAccount {
    var name: String?
    var photo: String?
    var agency: String?
    var accountType: String?
    var accountNumber: String?
    var accountBeneficited: String?
    
    init() {}
    
    init(name: String, photo: String, agency: String, accountType: String, accountNumber: String, accountBeneficited: String) {
        self.name = name
        self.photo = photo
        self.agency = agency
        self.accountType = accountType
        self.accountNumber = accountNumber
        self.accountBeneficited = accountBeneficited
    }
}
