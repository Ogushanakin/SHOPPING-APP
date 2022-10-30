//
//  ProductModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 30.10.2022.
//

import Foundation

struct ProductModel {
    let category: String
    let description: String
    let id: Int
    let image: String
    let title: String
    let price: Double
    
    init(dictionary: [String: Any]) {
        self.category = dictionary["category"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.id = (dictionary["id"] as? Int)!
        self.image = dictionary["image"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.price = (dictionary["price"] as? Double)!
    }
}
