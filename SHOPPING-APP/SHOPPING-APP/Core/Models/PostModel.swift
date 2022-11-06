//
//  PostModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 4.11.2022.
//

import Foundation

// MARK: - POSTModelElement
struct POSTModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let postModelDescription: String
    let category: Category
    let image: String
    let rating: Rating

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case postModelDescription = "description"
        case category, image, rating
    }
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
