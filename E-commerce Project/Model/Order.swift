//
//  Order.swift
//  E-commerce Project
//
//  Created by Binaya on 27/10/2021.
//

import Foundation

class Order {
    
    var id: UUID
    var totalAmount: Double
    var date: Date
    var products: [Product]
    var totalAmountAsAString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedAmount = numberFormatter.string(from: NSNumber(value: totalAmount))
        guard let validAmount = formattedAmount else { return "Rs." + String(format: "%.0f", totalAmount)}
        return "Rs." + validAmount
    }
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    init(id: UUID, totalAmount: Double, date: Date, products: [Product]) {
        self.id = id
        self.totalAmount = totalAmount
        self.date = date
        self.products = products
    }
    
}
