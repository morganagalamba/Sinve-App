//
//  Sales.swift
//  Sinve
//
//  Created by sml on 23/10/22.
//

import Foundation

struct Sales: Codable, Hashable {
    let prod: [Products]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case prod = "produtos"
        case date = "data"
    }
}

struct Products: Codable, Hashable {
    let quantity: Int
    let price: Int
    let name : String
    
    enum CodingKeys: String, CodingKey {
        case quantity = "quantidade"
        case price = "precoDeVenda"
        case name = "nome"
    }
}
