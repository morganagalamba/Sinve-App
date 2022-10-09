//
//  Produto.swift
//  Sinve
//
//  Created by Morgana Galamba on 09/10/22.
//

import Foundation

struct Produto: Codable, Hashable {
    let id: String?
    let nome: String?
    let categoria: String?
    let precoPorUnidade: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nome = "nome"
        case categoria = "categoria"
        case precoPorUnidade = "precoPorUnidade"
    }
}
