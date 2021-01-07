//
//  Subgroup.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 06/01/21.
//  Copyright © 2021 Juan Souza. All rights reserved.
//

import Foundation

class Subgroup : NSObject, NSCoding{

    var id : String!
    var grupo : String!
    var inscritos : [String]!
    var vagasDisponiveisSubgrupo : Int!
    var vagasSubgrupo : Int!

    override init(){}
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["_id"] as? String
        grupo = dictionary["grupo"] as? String
        inscritos = dictionary["inscritos"] as? [String]
        vagasDisponiveisSubgrupo = dictionary["vagasDisponiveisSubgrupo"] as? Int
        vagasSubgrupo = dictionary["vagasSubgrupo"] as? Int
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
        if grupo != nil{
            dictionary["grupo"] = grupo
        }
        if inscritos != nil{
            dictionary["inscritos"] = inscritos
        }
        if vagasDisponiveisSubgrupo != nil{
            dictionary["vagasDisponiveisSubgrupo"] = vagasDisponiveisSubgrupo
        }
        if vagasSubgrupo != nil{
            dictionary["vagasSubgrupo"] = vagasSubgrupo
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
         grupo = aDecoder.decodeObject(forKey: "grupo") as? String
         inscritos = aDecoder.decodeObject(forKey: "inscritos") as? [String]
         vagasDisponiveisSubgrupo = aDecoder.decodeObject(forKey: "vagasDisponiveisSubgrupo") as? Int
         vagasSubgrupo = aDecoder.decodeObject(forKey: "vagasSubgrupo") as? Int

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
        if grupo != nil{
            aCoder.encode(grupo, forKey: "grupo")
        }
        if inscritos != nil{
            aCoder.encode(inscritos, forKey: "inscritos")
        }
        if vagasDisponiveisSubgrupo != nil{
            aCoder.encode(vagasDisponiveisSubgrupo, forKey: "vagasDisponiveisSubgrupo")
        }
        if vagasSubgrupo != nil{
            aCoder.encode(vagasSubgrupo, forKey: "vagasSubgrupo")
        }

    }

}
