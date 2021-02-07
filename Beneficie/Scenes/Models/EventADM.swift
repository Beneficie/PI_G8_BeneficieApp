//
//  EventADM.swift
//  Beneficie
//
//  Created by Dominique Nascimento Bezerra on 05/02/21.
//

import Foundation

struct EventADM: Codable {

    var _id : String?
    var clicksAcao : Int
    var data : String
    var descricao : String
    var local : String
    var subgrupos : [SubgroupADM]
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
