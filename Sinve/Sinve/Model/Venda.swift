//
//  Venda.swift
//  Sinve
//
//  Created by Morgana Galamba on 09/10/22.
//

import Foundation

struct Venda : Codable, Hashable {
    var nome: String
    var quantidade : Int32
    var data: String
    
    enum CodingKeys: String, CodingKey {
        case nome = "nome"
        case quantidade = "quantidade"
        case data = "data"
        
    }
}
