//
//  ProfileViewModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 27.10.2022.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case favorites
    case settings
    
    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .favorites: return "Favorites"
        case .settings: return "Settings"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .favorites: return "heart"
        case .settings: return "gear"
        }
    }
}
