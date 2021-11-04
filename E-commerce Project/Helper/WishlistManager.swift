//
//  WishlistManager.swift
//  E-commerce Project
//
//  Created by Binaya on 26/10/2021.
//

import Foundation

class WishlistManager {
    
    //MARK: - Properties

    static let shared = WishlistManager()
    private var wishlistProducts: [Product] = []

    //MARK: - Initializer

    private init () {}
    
    //MARK: - Instance methods
    
    func getWishlistProducts() -> [Product] {
        return wishlistProducts
    }
    
    func addToWishlist(_ product: Product) {
        wishlistProducts.append(product)
    }
    
    func deleteFromWishlist(at index: Int) {
        wishlistProducts.remove(at: index)
    }

}
