//
//  User.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 06/01/21.
//  Copyright © 2021 Juan Souza. All rights reserved.
//

import Foundation

struct User: Codable {

    let _id : String
    let admin : [Admin]
    let cpf : String
    let email : String
    let nome : String
    let password : String
    let subgrupo : String
    let telefone : String

    init(){
        _id = ""
        admin = []
        cpf = ""
        email = ""
        nome  = ""
        password = ""
        subgrupo = ""
        telefone = ""
    }
    


}
