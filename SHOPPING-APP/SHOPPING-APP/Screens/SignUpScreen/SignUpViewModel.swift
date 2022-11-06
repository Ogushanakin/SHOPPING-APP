//
//  SignUpViewModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//

import Foundation

struct SignUpViewModel {
    var email: String?
    var fullname: String?
    var username: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
            && password?.isEmpty == false
    }
}
