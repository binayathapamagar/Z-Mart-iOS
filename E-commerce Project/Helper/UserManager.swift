//
//  UserManager.swift
//  E-commerce Project
//
//  Created by Binaya on 27/10/2021.
//

import Foundation

class UserManager {
    
    //MARK: - Properties

    static let shared = UserManager()
    private var users: [User] = []

    //MARK: - Initializer

    private init () {}
    
    //MARK: - Instance methods
    
    func getUsers() -> [User] {
        return users
    }
    
    func addNewUser(_ user: User) {
        users.append(user)
    }
    
    func updateUser(user: User) {
        users[0] = user
    }
    
    func addNewOrder() {
        
        guard let user = users.first else { return }
        
        let products = CartManager.shared.getCartProducts()
        let totalPrice = products.reduce(0, {$0 + ($1.product.price * Double($1.quantity))})
        var orderProducts: [Product] = []
        products.forEach { cartProduct in
            orderProducts.append(cartProduct.product)
        }
        
        let order = Order(id: UUID(), totalAmount: totalPrice, date: Date(), products: orderProducts)
        user.orderHistory.append(order)
        
    }

}
