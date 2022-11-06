//
//  LoginViewModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//

import Foundation

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
}
