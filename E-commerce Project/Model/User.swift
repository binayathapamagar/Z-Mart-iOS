//
//  User.swift
//  E-commerce Project
//
//  Created by Binaya on 27/10/2021.
//

import Foundation

class User {
    var name: String
    var email: String
    var phone: String
    var password: String
    var orderHistory: [Order] = []
    
    init(name:String, email: String, phone: String, password: String) {
        self.name = name
        self.email = email
        self.phone = phone
        self.password = password
    }
}
