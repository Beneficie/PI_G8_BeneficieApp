//
//	Event.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Event : NSObject, NSCoding{

    var id : String!
    var clicksAcao : Int!
    var data : String!
    var descricao : String!
    var local : String!
    var subgrupos : [Subgroup]!
    var titulo : String!
    var vagasDisponiveis : Int!
    var vagasTotais : Int!

    override init(){}

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["_id"] as? String
        clicksAcao = dictionary["clicksAcao"] as? Int
        data = dictionary["data"] as? String
        descricao = dictionary["descricao"] as? String
        local = dictionary["local"] as? String
        subgrupos = [Subgroup]()
        if let subgroupsArray = dictionary["subgrupos"] as? [[String:Any]]{
            for dic in subgroupsArray{
                let value = Subgroup(fromDictionary: dic)
                subgrupos.append(value)
            }
        }
        titulo = dictionary["titulo"] as? String
        vagasDisponiveis = dictionary["vagasDisponiveis"] as? Int
        vagasTotais = dictionary["vagasTotais"] as? Int
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
        if clicksAcao != nil{
            dictionary["clicksAcao"] = clicksAcao
        }
        if data != nil{
            dictionary["data"] = data
        }
        if descricao != nil{
            dictionary["descricao"] = descricao
        }
        if local != nil{
            dictionary["local"] = local
        }
        if subgrupos != nil{
            var dictionaryElements = [[String:Any]]()
            for subgruposElement in subgrupos {
                dictionaryElements.append(subgruposElement.toDictionary())
            }
            dictionary["subgrupos"] = dictionaryElements
        }
        if titulo != nil{
            dictionary["titulo"] = titulo
        }
        if vagasDisponiveis != nil{
            dictionary["vagasDisponiveis"] = vagasDisponiveis
        }
        if vagasTotais != nil{
            dictionary["vagasTotais"] = vagasTotais
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
         clicksAcao = aDecoder.decodeObject(forKey: "clicksAcao") as? Int
         data = aDecoder.decodeObject(forKey: "data") as? String
         descricao = aDecoder.decodeObject(forKey: "descricao") as? String
         local = aDecoder.decodeObject(forKey: "local") as? String
         subgrupos = aDecoder.decodeObject(forKey :"subgrupos") as? [Subgroup]
         titulo = aDecoder.decodeObject(forKey: "titulo") as? String
         vagasDisponiveis = aDecoder.decodeObject(forKey: "vagasDisponiveis") as? Int
         vagasTotais = aDecoder.decodeObject(forKey: "vagasTotais") as? Int

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
        if clicksAcao != nil{
            aCoder.encode(clicksAcao, forKey: "clicksAcao")
        }
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if descricao != nil{
            aCoder.encode(descricao, forKey: "descricao")
        }
        if local != nil{
            aCoder.encode(local, forKey: "local")
        }
        if subgrupos != nil{
            aCoder.encode(subgrupos, forKey: "subgrupos")
        }
        if titulo != nil{
            aCoder.encode(titulo, forKey: "titulo")
        }
        if vagasDisponiveis != nil{
            aCoder.encode(vagasDisponiveis, forKey: "vagasDisponiveis")
        }
        if vagasTotais != nil{
            aCoder.encode(vagasTotais, forKey: "vagasTotais")
        }

    }

}
