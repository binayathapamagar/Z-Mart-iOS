//
//  CartProduct.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import Foundation

class CartProduct {
    
    var id: Int
    var quantity: Int
    var product: Product
    var dateAdded: Date
    
    init(id: Int, quantity: Int, product: Product, dateAdded: Date) {
        self.id = id
        self.quantity = quantity
        self.product = product
        self.dateAdded = dateAdded
    }
    
}
