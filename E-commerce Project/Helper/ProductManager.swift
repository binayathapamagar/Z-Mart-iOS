//
//  ProductManager.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import Foundation

struct ProductManager {
    
    private var products = [
        Product(id: 1, name: "Gaming Keyboard", description: "Redragon S101 Wired Gaming Keyboard and Mouse Combo RGB Backlit Gaming Keyboard with Multimedia Keys Wrist Rest and Red Backlit Gaming Mouse 3200 DPI for Windows PC Gamers (Black).", price: 2500, images: ["keyboard1", "keyboard2", "keyboard3"], quantity: 10, ratings: 4),
        
        Product(id: 2, name: "Full Gym Set", description: "MiM USA Hercules 1001, Commercial Smith Machine, Functional Trainer, Power Cage, Leg Press, Dip Chin, Jammer Arms, Adj. Weight Bench, Leg Extension & Full Accessories.", price: 80000, images: ["gym1", "gym2", "gym3"], quantity: 5, ratings: 5),
        
        Product(id: 3, name: "Men Joggers", description: "Essentials Men's Slim-Fit Jogger Pant.", price: 1500, images: ["joggers1", "joggers2", "joggers3"], quantity: 50, ratings: 3),
        
        Product(id: 4, name: "Beats by Dre", description: "Beats EP Wired On-Ear Headphones - Battery Free for Unlimited Listening, Built in Mic and Controls - Black.", price: 5999, images: ["headphones1", "headphones2", "headphones3"], quantity: 20, ratings: 4),
        
        Product(id: 5, name: "Lap Desk", description: "LapGear Home Office Lap Desk with Device Ledge, Mouse Pad, and Phone Holder - Silver Carbon - Fits Up to 15.6 Inch Laptops - Style.", price: 1899, images: ["desk1", "desk2", "desk3"], quantity: 30, ratings: 3),
        
        Product(id: 6, name: "X-Box Controller", description: "Wireless Controller for Microsoft Xbox Series X/S & Xbox One - Custom Soft Touch Feel - Custom Xbox Series X/S Controller (X/S Red & Black Fade).", price: 2999, images: ["controller1", "controller2", "controller3"], quantity: 25, ratings: 3),
        
        Product(id: 7, name: "BBQ Accessory Set", description: "BBQ Accessories – 16PC Grill Set with Spatula, Tongs, Skewers, Case – Barbecue Tools for Father’s Day, Wedding, Anniversary, 16 Piece, Silver.", price: 5235, images: ["bbq1", "bbq2", "bbq3"], quantity: 35, ratings: 3),
        
        Product(id: 8, name: "Health Tracker", description: "Fitbit Charge 5 Advanced Fitness & Health Tracker with Built-in GPS, Stress Management Tools, Sleep Tracking, 24/7 Heart Rate and More, Black/Graphite, One Size (S &L Bands Included).", price: 1980, images: ["health1", "health2", "health3"], quantity: 40, ratings: 4),
        
        Product(id: 9, name: "Tuft & Needle Mint Queen Mattress", description: "Tuft & Needle Mint Queen Mattress - Extra Cooling Adaptive Foam with Ceramic Gel Beads and Edge Support - Antimicrobial Protection Powered by HEIQ - CertiPUR-US.", price: 6790, images: ["mattress1", "mattress2", "mattress3"], quantity: 15, ratings: 3),
        
        Product(id: 10, name: "Jordan Bag", description: "Nike Air Jordan HBR Air Backpack (One Size, Black).", price: 1250, images: ["bag1", "bag2", "bag3"], quantity: 25, ratings: 3)
    ]
    
    //MARK: - Instance methods

    func getProducts() -> [Product] {
        return products.sorted { $0.name < $1.name }
    }
    
    
}
