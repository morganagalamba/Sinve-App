//
//  Fornecedor.swift
//  Sinve
//
//  Created by Morgana Galamba on 18/10/22.
//

import Foundation

struct Fornecedor: Codable, Hashable {

    var cnpj: String
    var nomeFantasia: String
    var prazoEntrega: Int
    var telefone: String
    
    enum CodingKeys: String, CodingKey {
        case cnpj = "CNPJ"
        case nomeFantasia = "nomeFantasia"
        case prazoEntrega = "prazoEntrega"
        case telefone = "telefone"
    }
}
