//
//  MainTabBarController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureViewControllers()
    }
    
    //MARK: - Helpers
    
    private func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let products = templateNavigationController(unselectedImage: UIImage(systemName: "shippingbox")!,
                                                    selectedImage: UIImage(systemName: "shippingbox")!,
                                                    title: "Products",
                                                    rootViewController: ProductsController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: UIImage(systemName: "magnifyingglass")!,
                                                  selectedImage: UIImage(systemName: "magnifyingglass")!,
                                                  title: "Search",
                                                  rootViewController: SearchController())
    
        let profile = templateNavigationController(unselectedImage: UIImage(systemName: "person")!,
                                                   selectedImage: UIImage(systemName: "person")!,
                                                   title: "Profile",
                                                   rootViewController: ProfileController())
                
        viewControllers = [products, search, profile]
        
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.title = title
        tabBar.tintColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        return nav
    }
}
