//
//	Event.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Event: Codable {

    var _id : String?
    var clicksAcao : Int
    var data : String
    var descricao : String
    var local : String
    var subgrupos : [Subgroup]
    var titulo : String
    var vagasDisponiveis : Int
    var vagasTotais : Int
    
    init(){
        _id = nil
        clicksAcao = 0
        data = ""
        descricao = ""
        local = ""
        subgrupos = []
        titulo = ""
        vagasDisponiveis = 0
        vagasTotais = 0
    }


}
