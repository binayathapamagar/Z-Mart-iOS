//
//  Product.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import Foundation

struct Product {
    
    var id: Int
    var name: String
    var description: String
    var price: Double
    var images: [String]
    var quantity: Int
    var ratings: Double
    var priceAs2DpString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedPrice = numberFormatter.string(from: NSNumber(value: price))
        guard let validPrice = formattedPrice else { return "Rs." + String(format: "%.0f", price)}
        return "Rs." + validPrice
    }
    var inWishlist = false
    
}
