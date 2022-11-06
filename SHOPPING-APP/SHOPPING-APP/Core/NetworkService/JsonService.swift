//
//  JSONService.swift
//  SHOPPING-APP
//
//  Created by AKIN on 4.11.2022.
//

import Alamofire

protocol JsonPlaceHolderProtocol {
    func fetchAllPosts(onSuccess:@escaping ([POSTModel])-> Void, onFail:@escaping (String?) -> Void)
}

enum JsonPath: String {
    case POSTS = "/products"
}

extension JsonPath {
    func withBaseUrl() -> String {
        return "https://fakestoreapi.com\(self.rawValue)"
    }
}

struct JsonService: JsonPlaceHolderProtocol {
    func fetchAllPosts(onSuccess:@escaping ([POSTModel]) -> Void, onFail:@escaping (String?) -> Void) {
        AF.request(JsonPath.POSTS.withBaseUrl(), method: .get).validate().responseDecodable(of: [POSTModel].self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}

