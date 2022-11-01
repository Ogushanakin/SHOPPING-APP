//
//  ProductViewModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 31.10.2022.
//

import Foundation

struct ProductViewModel {
    var product: ProductModel
    
    var imageUrl: URL? { return URL(string: product.image) }
    
    var title: String { return product.title }
    
    var price: String { return String(product.price) }
    
    var description: String { return product.description }
    
    init(product: ProductModel) {
        self.product = product
    }
}
