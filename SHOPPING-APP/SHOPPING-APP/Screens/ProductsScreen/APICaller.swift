//
//  APICaller.swift
//  SHOPPING-APP
//
//  Created by AKIN on 27.10.2022.
//

import Foundation


struct Constant {
    static let baseURL = "https://fakestoreapi.com"
}


class APICaller {
    static let shared = APICaller()
    
    func getJewelery(completion: @escaping (String) -> Void) {
        
        guard let url = URL(string: "\(Constant.baseURL)/products/category/jewelery") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
