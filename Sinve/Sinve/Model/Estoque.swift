//
//  Estoque.swift
//  Sinve
//
//  Created by Morgana Galamba on 18/10/22.
//

import Foundation

struct Estoque: Codable, Hashable {
    var id: String
    var nome: String
    var quantidade: Int
    var estoqueIdeal: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nome = "nome"
        case quantidade = "quantidade"
        case estoqueIdeal = "estoqueIdeal"
    }
}
