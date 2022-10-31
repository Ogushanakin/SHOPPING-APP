//
//  PostServiceProductService.swift
//  SHOPPING-APP
//
//  Created by AKIN on 31.10.2022.
//

import UIKit
import Firebase

struct ProductService {
    
    static func fetchProducts(completion: @escaping([ProductModel]) -> Void) {
        COLLECTION_PRODUCT.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }

            let products = documents.map({ ProductModel(id: $0.documentID, dictionary: $0.data()) })
            completion(products)
        }
    }
}


