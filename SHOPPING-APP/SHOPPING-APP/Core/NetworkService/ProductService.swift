//
//  PostServiceProductService.swift
//  SHOPPING-APP
//
//  Created by AKIN on 31.10.2022.
//

import UIKit
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct ProductService {
    
    static func fetchProducts(completion: @escaping([ProductModel]) -> Void) {
        COLLECTION_PRODUCT.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let products = documents.map({ ProductModel(id: $0.documentID, dictionary: $0.data()) })
            completion(products)
        }
    }
    
    static func fetchMens(completion: @escaping([ProductModel]) -> Void) {
        COLLECTION_MEN.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let products = documents.map({ ProductModel(id: $0.documentID, dictionary: $0.data()) })
            completion(products)
        }
    }
    
    static func fetchWomens(completion: @escaping([ProductModel]) -> Void) {
        COLLECTION_WOMEN.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let products = documents.map({ ProductModel(id: $0.documentID, dictionary: $0.data()) })
            completion(products)
        }
    }
    
    static func fetchElectronics(completion: @escaping([ProductModel]) -> Void) {
        COLLECTION_ELECTRONIC.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let products = documents.map({ ProductModel(id: $0.documentID, dictionary: $0.data()) })
            completion(products)
        }
    }
    
    static func fetchJeweleries(completion: @escaping([ProductModel]) -> Void) {
        COLLECTION_JEWELERY.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let products = documents.map({ ProductModel(id: $0.documentID, dictionary: $0.data()) })
            completion(products)
        }
    }
    
    static func addCart(product: ProductModel, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_PRODUCT.document(product.id).updateData(["carts": product.carted + 1])
        
        COLLECTION_PRODUCT.document(product.id).collection("product-carts").document(uid).setData([:]) { _ in
            
            COLLECTION_USERS.document(uid).collection("user-carts").document(product.id).setData([:], completion: completion)
        }
    }
    
}


