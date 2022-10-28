//
//  SideMenuViewModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 28.10.2022.
//

enum SideMenuViewModel: Int, CaseIterable {
    case accountInfo
    case favorites
    case notifications
    case campaign
    case settings
    
    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .favorites: return "Favorites"
        case .notifications: return "Notifications"
        case .campaign: return "Campaign"
        case .settings: return "Settings"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .favorites: return "heart"
        case .notifications: return "bell"
        case .campaign: return "megaphone"
        case .settings: return "gear"
        }
    }
}
