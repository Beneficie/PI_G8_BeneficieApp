//
//  User.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 06/01/21.
//

import Foundation

struct User: Codable {

    let _id : String
    var email : String?
    var name : String
    var phoneNumber : String?
    let uid: String
    let isAdmin: Bool?

    init(){
        _id = ""
        email = ""
        name  = ""
        phoneNumber = ""
        uid = ""
        isAdmin = nil
    }
    


}
