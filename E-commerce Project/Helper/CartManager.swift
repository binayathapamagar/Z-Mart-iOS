//
//  CartManager.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import Foundation

enum UpdateCartFrom {
    case ProductDetails
    case Cart
    case Wishlist
}

class CartManager {

    //MARK: - Properties

    private var products: [CartProduct] = []
    static let shared = CartManager()
    private var uniqueId: Int {
        return products.count == 0 ? 1 : products[products.count - 1].id + 1
    }
    
    //MARK: - Initializer

    private init () {}
    
    //MARK: - Instance methods
    
    func getCartProducts() -> [CartProduct] {
        return products.sorted { $0.dateAdded < $1.dateAdded }
    }
    
    func addToCart(_ product: Product, quantity: Int = 1, from location: UpdateCartFrom) -> String? {
        
        if let cartProductIndex = products.firstIndex(where: { $0.product.id == product.id }) {

            let cartProduct = products[cartProductIndex]

            if location == UpdateCartFrom.Wishlist {
                return "Item '\(cartProduct.product.name)' already exists in cart"
            }
            
            if cartProduct.quantity < cartProduct.product.quantity {
                
                cartProduct.quantity = quantity == 1 && location == UpdateCartFrom.Cart ? cartProduct.quantity + 1 : quantity
            }else {
                return "Item '\(cartProduct.product.name)' maximum quantity available has been reached!"
            }

        }else {
            
            let cartProduct = CartProduct(id: uniqueId, quantity: quantity, product: product, dateAdded: Date())
            products.append(cartProduct)
            
        }
        
        return nil
                
    }
    
    func decreaseQuantity(_ product: Product) {
        if let cartProductIndex = products.firstIndex(where: { $0.product.id == product.id }) {
            let cartProduct = products[cartProductIndex]
            if cartProduct.quantity > 1 {
                cartProduct.quantity -= 1
            }
        }
    }
    
    func deleteFromCart(at index: Int) {
        products.remove(at: index)
    }
    
    func removeAllItems() {
        products.removeAll()
    }
    
}
