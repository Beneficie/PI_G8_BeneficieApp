//
//  File.swift
//  Beneficie
//
//  Created by Dominique Nascimento Bezerra on 05/02/21.
//  Copyright © 2021 Juan Souza. All rights reserved.
//

import Foundation

struct SubgroupADM : Codable {

    var _id : String?
    var grupo : String
    var inscritos : [User]
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
