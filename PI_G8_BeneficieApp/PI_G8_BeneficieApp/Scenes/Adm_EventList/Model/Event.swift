//
//	Event.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Event : NSObject, NSCoding{

	var id : String!
	var data : String!
	var descricao : String!
	var grupos : Int!
	var local : String!
	var titulo : String!
	var vagasDisponiveis : Int!
	var vagasTotais : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["_id"] as? String
		data = dictionary["data"] as? String
		descricao = dictionary["descricao"] as? String
		grupos = dictionary["grupos"] as? Int
		local = dictionary["local"] as? String
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
		if data != nil{
			dictionary["data"] = data
		}
		if descricao != nil{
			dictionary["descricao"] = descricao
		}
		if grupos != nil{
			dictionary["grupos"] = grupos
		}
		if local != nil{
			dictionary["local"] = local
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
         data = aDecoder.decodeObject(forKey: "data") as? String
         descricao = aDecoder.decodeObject(forKey: "descricao") as? String
         grupos = aDecoder.decodeObject(forKey: "grupos") as? Int
         local = aDecoder.decodeObject(forKey: "local") as? String
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
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if descricao != nil{
			aCoder.encode(descricao, forKey: "descricao")
		}
		if grupos != nil{
			aCoder.encode(grupos, forKey: "grupos")
		}
		if local != nil{
			aCoder.encode(local, forKey: "local")
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