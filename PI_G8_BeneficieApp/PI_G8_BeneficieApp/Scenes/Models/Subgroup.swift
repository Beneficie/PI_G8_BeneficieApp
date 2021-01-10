//    Subgrupo.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Subgroup : Codable {

    var _id : String?
    var grupo : String
    var inscritos : [String]
    var vagasDisponiveisSubgrupo : Int
    var vagasSubgrupo : Int

    init() {
        _id = nil
        grupo = ""
        inscritos = []
        vagasDisponiveisSubgrupo = 0
        vagasSubgrupo = 0
    }


}
