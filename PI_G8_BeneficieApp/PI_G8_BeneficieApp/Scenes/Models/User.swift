//
//  User.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 06/01/21.
//  Copyright © 2021 Juan Souza. All rights reserved.
//

import Foundation

class User : NSObject, NSCoding{

    var id : String!
    var admin : [Admin]!
    var cpf : String!
    var email : String!
    var nome : String!
    var password : String!
    var subgrupo : String!
    var telefone : String!

    override init(){}
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["_id"] as? String
        admin = [Admin]()
        if let adminArray = dictionary["admin"] as? [[String:Any]]{
            for dic in adminArray{
                let value = Admin(fromDictionary: dic)
                admin.append(value)
            }
        }
        cpf = dictionary["cpf"] as? String
        email = dictionary["email"] as? String
        nome = dictionary["nome"] as? String
        password = dictionary["password"] as? String
        subgrupo = dictionary["subgrupo"] as? String
        telefone = dictionary["telefone"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["_id"] = id
        }
        if admin != nil{
            var dictionaryElements = [[String:Any]]()
            for adminElement in admin {
                dictionaryElements.append(adminElement.toDictionary())
            }
            dictionary["admin"] = dictionaryElements
        }
        if cpf != nil{
            dictionary["cpf"] = cpf
        }
        if email != nil{
            dictionary["email"] = email
        }
        if nome != nil{
            dictionary["nome"] = nome
        }
        if password != nil{
            dictionary["password"] = password
        }
        if subgrupo != nil{
            dictionary["subgrupo"] = subgrupo
        }
        if telefone != nil{
            dictionary["telefone"] = telefone
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         id = aDecoder.decodeObject(forKey: "_id") as? String
         admin = aDecoder.decodeObject(forKey :"admin") as? [Admin]
         cpf = aDecoder.decodeObject(forKey: "cpf") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         nome = aDecoder.decodeObject(forKey: "nome") as? String
         password = aDecoder.decodeObject(forKey: "password") as? String
         subgrupo = aDecoder.decodeObject(forKey: "subgrupo") as? String
         telefone = aDecoder.decodeObject(forKey: "telefone") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if admin != nil{
            aCoder.encode(admin, forKey: "admin")
        }
        if cpf != nil{
            aCoder.encode(cpf, forKey: "cpf")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if nome != nil{
            aCoder.encode(nome, forKey: "nome")
        }
        if password != nil{
            aCoder.encode(password, forKey: "password")
        }
        if subgrupo != nil{
            aCoder.encode(subgrupo, forKey: "subgrupo")
        }
        if telefone != nil{
            aCoder.encode(telefone, forKey: "telefone")
        }

    }

}
