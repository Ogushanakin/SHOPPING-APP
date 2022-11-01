//
//  ProductModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 30.10.2022.
//

import Firebase

struct ProductModel {
    let description: String
    let id: String
    let image: String
    let title: String
    var price: Double
    var carted: Int
    var didAddCart = false
    
    init(id: String, dictionary: [String: Any]) {
        self.id = id
        self.description = dictionary["description"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.price = dictionary["price"] as? Double ?? 0.00
        self.carted = dictionary["carted"] as? Int ?? 0
    }
}
