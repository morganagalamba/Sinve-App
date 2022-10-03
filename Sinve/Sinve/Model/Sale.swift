//
//  Sale.swift
//  Sinve
//
//  Created by Morgana Galamba on 03/10/22.
//

import Foundation

class Sale{
    var prod: Product
    var amount: Int
    init(prod: Product, amount: Int) {
        self.prod = prod
        self.amount = amount
    }
}

class Product {
    var barcode: String
    var price: Int
    var name : String
    init(barcode: String, price: Int, name: String) {
        self.barcode = barcode
        self.price = price
        self.name = name
    }
}
